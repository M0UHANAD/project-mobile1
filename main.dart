import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart';
import 'points_summary_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Points Counter',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: LoginPage(
        themeMode: _themeMode,
        toggleTheme: toggleTheme,
      ),
    );
  }
}

class PointCounter extends StatefulWidget {
  final String teamAName;
  final String teamBName;
  final String refereeName;
  final ThemeMode themeMode;
  final Function toggleTheme;

  PointCounter({
    required this.teamAName,
    required this.teamBName,
    required this.refereeName,
    required this.themeMode,
    required this.toggleTheme,
  });

  @override
  State<PointCounter> createState() => _PointCounterState();
}

class _PointCounterState extends State<PointCounter> {
  int teamAPoints = 0;
  int teamBPoints = 0;

  // Initialize selectedPoints and bonusChecked variables
  int selectedPoints = 1; // Default selected point for radio button
  bool bonusChecked = false; // Default state for the checkbox

  Future<void> saveMatchRecord() async {
    try {
      final url = Uri.parse('http://osmanrmd.atwebpages.com/main.php');

      final body = jsonEncode({
        'action': 'save_match',
        'team1': widget.teamAName,
        'team2': widget.teamBName,
        'score_team1': teamAPoints,
        'score_team2': teamBPoints,
        'referee': widget.refereeName,
      });

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final status = responseBody['status'] ?? 'error';
        final message =
            responseBody['message'] ?? 'An unexpected error occurred';

        if (status == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Colors.green,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        throw Exception(
            'Server responded with status code ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(' ${e.toString()}'),
        backgroundColor: const Color.fromARGB(255, 244, 54, 54),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: const Text(
          'Points Counter',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 3,
                color: Color(0x66000000),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.themeMode == ThemeMode.dark
                  ? Icons.nightlight_round
                  : Icons.wb_sunny,
              color: Colors.white,
            ),
            onPressed: () {
              widget.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PointsSummaryPage(
                    teamAPoints: teamAPoints,
                    teamBPoints: teamBPoints,
                    teamAName: widget.teamAName,
                    teamBName: widget.teamBName,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Referee: ${widget.refereeName}', // Referee info
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildTeamColumn(
                  widget.teamAName, teamAPoints, true), // True for Team A
              const SizedBox(
                height: 400,
                child: VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 8,
                ),
              ),
              buildTeamColumn(
                  widget.teamBName, teamBPoints, false), // False for Team B
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 1; i <= 3; i++)
                Row(
                  children: [
                    Radio<int>(
                      value: i,
                      groupValue: selectedPoints,
                      onChanged: (value) {
                        setState(() {
                          selectedPoints = value!;
                        });
                      },
                    ),
                    Text('$i'),
                  ],
                ),
            ],
          ),
          CheckboxListTile(
            title: const Text('Add Bonus 5 Points'),
            value: bonusChecked,
            onChanged: (bool? value) {
              setState(() {
                bonusChecked = value!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              await saveMatchRecord();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              minimumSize: const Size(150, 50),
            ),
            child: const Text(
              'Save Match Record',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                teamAPoints = 0;
                teamBPoints = 0;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              minimumSize: const Size(100, 40),
            ),
            child: const Text(
              'Reset',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  // Updated to include the boolean flag for team
  Column buildTeamColumn(String team, int points, bool isTeamA) {
    return Column(
      children: [
        Text(
          team,
          style: const TextStyle(fontSize: 40),
        ),
        Text(
          '$points',
          style: const TextStyle(fontSize: 140),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (isTeamA) {
                teamAPoints += selectedPoints + (bonusChecked ? 5 : 0);
              } else {
                teamBPoints += selectedPoints + (bonusChecked ? 5 : 0);
              }
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            minimumSize: const Size(150, 60),
          ),
          child: Text(
            'Add $selectedPoints point${selectedPoints > 1 ? "s" : ""}',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
