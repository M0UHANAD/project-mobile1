import 'package:flutter/material.dart';
import 'main.dart';  // Import the main page to pass the custom names
import 'points_summary_page.dart'; // Import the point counter page

class TeamNamePage extends StatefulWidget {
  final ThemeMode themeMode;   // Add themeMode to the widget
  final Function toggleTheme;  // Add toggleTheme to the widget

  // Accept themeMode and toggleTheme as parameters in the constructor
  TeamNamePage({
    required this.themeMode,
    required this.toggleTheme,
  });

  @override
  _TeamNamePageState createState() => _TeamNamePageState();
}

class _TeamNamePageState extends State<TeamNamePage> {
  final TextEditingController teamAController = TextEditingController();
  final TextEditingController teamBController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: const Text(
          'Enter team names',
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
        actions: [
          IconButton(
            icon: Icon(
              widget.themeMode == ThemeMode.dark
                  ? Icons.nightlight_round
                  : Icons.wb_sunny,
              color: Colors.white,
            ),
            onPressed: () {
              widget.toggleTheme();  // Toggle theme when clicked
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: teamAController,
              decoration: const InputDecoration(
                labelText: 'Team A Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: teamBController,
              decoration: const InputDecoration(
                labelText: 'Team B Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                String teamAName = teamAController.text.isEmpty ? 'Team A' : teamAController.text;
                String teamBName = teamBController.text.isEmpty ? 'Team B' : teamBController.text;

                // Pass themeMode, toggleTheme, and team names to the PointCounter
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PointCounter(
                      teamAName: teamAName,
                      teamBName: teamBName,
                      themeMode: widget.themeMode,   // Pass themeMode
                      toggleTheme: widget.toggleTheme, // Pass toggleTheme
                    ),
                  ),
                );
              },
              child: const Text('Start Game'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: const Size(150, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
