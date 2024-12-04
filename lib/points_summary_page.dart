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
        title: const Text(
          'Points Summary',
          style: TextStyle(
            fontSize: 30, // Increased font size
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.white, // White color for better contrast
            letterSpacing: 2, // Letter spacing for a cleaner look
            shadows: [
              Shadow(
                offset: Offset(2, 2), // Shadow offset
                blurRadius: 3, // Shadow blur radius
                color: Color(0x66000000), // Semi-transparent black shadow
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center( // This ensures everything is centered on the screen
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers the content vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Centers the content horizontally
            children: [
              const Text('Team A Points:', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              for (var entry in teamACounts.entries)
                Text('${entry.key}: ${entry.value}', style: const TextStyle(fontSize: 30)),
              const SizedBox(height: 20),
              const Text('Team B Points:', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              for (var entry in teamBCounts.entries)
                Text('${entry.key}: ${entry.value}', style: const TextStyle(fontSize: 30)),
              const SizedBox(height: 40),
              Text(
                winner,
                style: TextStyle(
                  fontSize: 48,  // Increased font size for the winner text
                  fontWeight: FontWeight.bold,
                  color: winnerColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
