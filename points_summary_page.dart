import 'package:flutter/material.dart';
import 'MatchListPage.dart';

class PointsSummaryPage extends StatelessWidget {
  final int teamAPoints;
  final int teamBPoints;
  final String teamAName;
  final String teamBName;

  PointsSummaryPage({
    required this.teamAPoints,
    required this.teamBPoints,
    required this.teamAName,
    required this.teamBName,
  });

  @override
  Widget build(BuildContext context) {
    String winner;
    if (teamAPoints > teamBPoints) {
      winner = teamAName;
    } else if (teamBPoints > teamAPoints) {
      winner = teamBName;
    } else {
      winner = "It's a draw!";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Match Summary',
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
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Match Summary',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTeamSummary(teamAName, teamAPoints),
                buildTeamSummary(teamBName, teamBPoints),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              winner == "It's a draw!"
                  ? "The match is a draw!"
                  : "Winner: $winner",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: winner == "It's a draw!" ? Colors.grey : Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchListPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: const Size(150, 50),
              ),
              child: const Text(
                'View All Matches',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTeamSummary(String teamName, int points) {
    return Column(
      children: [
        Text(
          teamName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          '$points Points',
          style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
        ),
      ],
    );
  }
}
