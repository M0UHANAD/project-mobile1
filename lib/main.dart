import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';  // Import intl package
import 'teamnamepage.dart';
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
  final String matchDate;
  final String refereeName; // Add refereeName to the constructor
  final ThemeMode themeMode;
  final Function toggleTheme;

  PointCounter({
    required this.teamAName,
    required this.teamBName,
    required this.matchDate,
    required this.refereeName, // Accept referee name in constructor
    required this.themeMode,
    required this.toggleTheme,
  });

  @override
  State<PointCounter> createState() => _PointCounterState();
}

class _PointCounterState extends State<PointCounter> {
  int teamAPoints = 0;
  int teamBPoints = 0;

  // Method to format match date before sending to server
  String formatDateForAPI(String matchDate) {
    try {
      // Convert the match date to DateTime object if it's not already
      DateTime date = DateTime.parse(matchDate);
      // Format the DateTime object to MySQL-friendly format (YYYY-MM-DD HH:mm:ss)
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    } catch (e) {
      // If the date can't be parsed, return an empty string or show error
      throw Exception('Invalid date format');
    }
  }

  Future<void> saveMatchRecord() async {
    try {
      final url = Uri.parse('http://osmanrmd.atwebpages.com/main.php');

      // Ensure matchDate is valid and format it
      if (widget.matchDate.isEmpty) {
        throw Exception('Match date is missing');
      }

      String formattedDate = formatDateForAPI(widget.matchDate); // Format the date

      // Prepare the POST request body
      final body = jsonEncode({
        'action': 'save_match',
        'date': formattedDate, // Send formatted date
        'team1': widget.teamAName, // Team A name
        'team2': widget.teamBName, // Team B name
        'score_team1': teamAPoints, // Team A points
        'score_team2': teamBPoints, // Team B points
        'referee': widget.refereeName, // Add referee name to the request
      });

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // Process the server's response
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final status = responseBody['status'] ?? 'error';
        final message = responseBody['message'] ?? 'An unexpected error occurred';

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
      // Catch any exceptions and show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: Text(
          'Date: ${widget.matchDate} ', // Display referee name in the app bar
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
                    teamACounts: {},
                    teamBCounts: {},
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Add the Row for the Referee Name above the Column
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Referee: ${widget.refereeName}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildTeamColumn(widget.teamAName, teamAPoints),
              const SizedBox(
                height: 400,
                child: VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 8,
                ),
              ),
              buildTeamColumn(widget.teamBName, teamBPoints),
            ],
          ),
          const SizedBox(height: 20),
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

  Column buildTeamColumn(String team, int points) {
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
              if (team == widget.teamAName) {
                teamAPoints += 1;
              } else {
                teamBPoints += 1;
              }
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            minimumSize: const Size(150, 60),
          ),
          child: const Text(
            'Add 1 Point',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
