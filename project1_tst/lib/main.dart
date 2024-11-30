import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    home: PointCounter(

    ),
  ));
}

class PointCounter extends StatefulWidget {
  @override
  State<PointCounter> createState() => _PointCounterState();
}

class _PointCounterState extends State<PointCounter> {
  int teamAPoints = 0;
  int teamBPoints = 0;
  int selectedPoints = 1;
  bool bonusChecked = false;
  bool isDarkTheme = false;

  
  final Map<String, int> teamACounts = {'1 Point': 0, '2 Points': 0, '3 Points': 0};
  final Map<String, int> teamBCounts = {'1 Point': 0, '2 Points': 0, '3 Points': 0};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: const Text('Points Counter'),
        actions: [
          IconButton(
            icon: Icon(
              isDarkTheme ? Icons.nightlight_round : Icons.wb_sunny,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isDarkTheme = !isDarkTheme;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PointsSummaryPage(
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
              buildTeamColumn('Team A', teamAPoints, teamACounts),
              const SizedBox(
                height: 460,
                child: VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 8,
                ),
              ),
              buildTeamColumn('Team B', teamBPoints, teamBCounts),
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
          const SizedBox(height: 40),
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
              minimumSize: const Size(150, 60),
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
              if (team == 'Team A') {
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

class PointsSummaryPage extends StatelessWidget {
  final Map<String, int> teamACounts;
  final Map<String, int> teamBCounts;

  PointsSummaryPage({required this.teamACounts, required this.teamBCounts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: const Text('Points Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Team A Points:', style: TextStyle(fontSize: 22)),
            for (var entry in teamACounts.entries)
              Text('${entry.key}: ${entry.value}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text('Team B Points:', style: TextStyle(fontSize: 22)),
            for (var entry in teamBCounts.entries)
              Text('${entry.key}: ${entry.value}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
