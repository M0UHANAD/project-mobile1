// points_summary_page.dart
import 'package:flutter/material.dart';

class PointsSummaryPage extends StatelessWidget {
  final Map<String, int> teamACounts;
  final Map<String, int> teamBCounts;
  final int teamAPoints;
  final int teamBPoints;

  PointsSummaryPage({
    required this.teamACounts,
    required this.teamBCounts,
    required this.teamAPoints,
    required this.teamBPoints,
  });

  @override
  Widget build(BuildContext context) {
    String winner = '';
    Color winnerColor = Colors.grey;

    if (teamAPoints > teamBPoints) {
      winner = 'Team A Wins!';
      winnerColor = Colors.green;
    } else if (teamBPoints > teamAPoints) {
      winner = 'Team B Wins!';
      winnerColor = Colors.blue;
    } else {
      winner = 'It\'s a Draw!';
      winnerColor = Colors.orange;
    }

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
            const SizedBox(height: 40),
            Text(
              winner,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: winnerColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
