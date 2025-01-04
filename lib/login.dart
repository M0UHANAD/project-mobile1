import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'teamnamepage.dart'; // Import the TeamNamePage
import 'Signup.dart'; // Import the SignUpPage

class LoginPage extends StatefulWidget {
  final ThemeMode themeMode;  // Declare themeMode
  final Function toggleTheme; // Declare toggleTheme

  LoginPage({
    required this.themeMode,
    required this.toggleTheme,
  });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String _message = '';

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _message = 'Email and password are required';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://osmanrmd.atwebpages.com/conx.php'),
        body: {
          'action': 'login',
          'email': email,
          'password': password,
        },
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseBody['status'] == 'success') {
          setState(() {
            _message = 'Login successful!';
          });

          final String refereeName = responseBody['referee_name']; // Get the referee's name

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TeamNamePage(
                refereeName: refereeName, // Pass refereeName to TeamNamePage
                themeMode: widget.themeMode,   // Pass themeMode here
                toggleTheme: widget.toggleTheme, // Pass toggleTheme function
              ),
            ),
          );
        } else {
          setState(() {
            _message = responseBody['message'] ?? 'Unknown error';
          });
        }
      } else {
        setState(() {
          _message = 'Failed to connect to server';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading ? CircularProgressIndicator() : Text('Login'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ),
                );
              },
              child: Text('Don’t have an account? Sign Up'),
            ),
            SizedBox(height: 20),
            Text(
              _message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
