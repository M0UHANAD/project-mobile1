import 'package:flutter/material.dart';
import 'teamnamepage.dart';  // Import the team name page
import 'points_summary_page.dart';  // Import the new summary page file

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Start with light theme
  ThemeMode _themeMode = ThemeMode.light;

  // Toggle between light and dark themes
  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Points Counter',
      theme: ThemeData.light(), // Light theme configuration
      darkTheme: ThemeData.dark(), // Dark theme configuration
      themeMode: _themeMode, // Set the current theme mode (light or dark)
      home: TeamNamePage(  // Pass themeMode and toggleTheme here
        themeMode: _themeMode,
        toggleTheme: toggleTheme,
      ),
    );
  }
}
class PointCounter extends StatefulWidget {
  final String teamAName;      // Add teamAName as a parameter
  final String teamBName;      // Add teamBName as a parameter
  final ThemeMode themeMode;   // Add themeMode as a parameter
  final Function toggleTheme;  // Add toggleTheme as a parameter

  PointCounter({
    required this.teamAName,
    required this.teamBName,
    required this.themeMode,   // Pass the themeMode here
    required this.toggleTheme, // Pass the toggleTheme function here
  });

  @override
  State<PointCounter> createState() => _PointCounterState();
}

class _PointCounterState extends State<PointCounter> {
  int teamAPoints = 0;
  int teamBPoints = 0;
  int selectedPoints = 1;
  bool bonusChecked = false;

  final Map<String, int> teamACounts = {'1 Point': 0, '2 Points': 0, '3 Points': 0};
  final Map<String, int> teamBCounts = {'1 Point': 0, '2 Points': 0, '3 Points': 0};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: const Text('Basketball Points Counter', 
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
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
              // Change the icon based on the current theme mode passed from the parent widget
              widget.themeMode == ThemeMode.dark
                  ? Icons.nightlight_round
                  : Icons.wb_sunny,
              color: Colors.white,
            ),
            onPressed: () {
              widget.toggleTheme();  // Toggle the theme mode when clicked
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
                    teamACounts: teamACounts,
                    teamBCounts: teamBCounts,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildTeamColumn(widget.teamAName, teamAPoints, teamACounts),
              const SizedBox(
                height: 400,
                child: VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 8,
                ),
              ),
              buildTeamColumn(widget.teamBName, teamBPoints, teamBCounts),
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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                teamAPoints = 0;
                teamBPoints = 0;
                teamACounts.updateAll((key, value) => 0);
                teamBCounts.updateAll((key, value) => 0);
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

  Column buildTeamColumn(String team, int points, Map<String, int> counts) {
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
                teamAPoints += selectedPoints + (bonusChecked ? 5 : 0);
                updateCounts(teamACounts, selectedPoints);
              } else {
                teamBPoints += selectedPoints + (bonusChecked ? 5 : 0);
                updateCounts(teamBCounts, selectedPoints);
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

  void updateCounts(Map<String, int> counts, int points) {
    if (points == 1) {
      counts['1 Point'] = counts['1 Point']! + 1;
    } else if (points == 2) {
      counts['2 Points'] = counts['2 Points']! + 1;
    } else if (points == 3) {
      counts['3 Points'] = counts['3 Points']! + 1;
    }
  }
}
