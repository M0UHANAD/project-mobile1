import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'points_summary_page.dart'; 
import 'main.dart';// Import the point counter page

class TeamNamePage extends StatefulWidget {
  final ThemeMode themeMode;
  final Function toggleTheme;
  final String refereeName; // Add refereeName as a parameter

  TeamNamePage({
    required this.themeMode,
    required this.toggleTheme,
    required this.refereeName, // Accept referee name in constructor
  });

  @override
  _TeamNamePageState createState() => _TeamNamePageState();
}

class _TeamNamePageState extends State<TeamNamePage> {
  String? selectedTeamA;
  String? selectedTeamB;
  String newTeamName = '';
  String matchDate = '';
  List<String> teamNames = [];
  bool isAddingNewTeam = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTeams();
  }

  Future<void> fetchTeams() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://osmanrmd.atwebpages.com/team.php'),
        body: {'action': 'fetch_teams'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            teamNames = List<String>.from(data['teams'].map((team) => team['team_name']));
          });
        } else {
          setState(() {
            teamNames = [];
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No teams available')));
        }
      } else {
        setState(() {
          teamNames = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load teams. Server error.')));
      }
    } catch (error) {
      setState(() {
        teamNames = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error occurred: $error')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addTeam() async {
    if (newTeamName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a team name')));
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://osmanrmd.atwebpages.com/team.php'),
        body: {
          'action': 'add_team',
          'team_name': newTeamName,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          fetchTeams();
          setState(() {
            isAddingNewTeam = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Team added successfully')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add team')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error occurred while adding the team')));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error occurred: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Select Teams',
          style: TextStyle(
            fontSize: 30,
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
              widget.themeMode == ThemeMode.dark ? Icons.nightlight_round : Icons.wb_sunny,
              color: Colors.white,
            ),
            onPressed: () {
              widget.toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              CircularProgressIndicator()
            else if (teamNames.isEmpty)
              Text('No teams available. Please add a team.')
            else ...[
              DropdownButton<String>(
                hint: Text('Select Team A'),
                value: selectedTeamA,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTeamA = newValue;
                  });
                },
                items: teamNames.map((teamName) {
                  return DropdownMenuItem<String>(value: teamName, child: Text(teamName));
                }).toList(),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                hint: Text('Select Team B'),
                value: selectedTeamB,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTeamB = newValue;
                  });
                },
                items: teamNames.map((teamName) {
                  return DropdownMenuItem<String>(value: teamName, child: Text(teamName));
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {
                    matchDate = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Match Date (yyyy-mm-dd)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isAddingNewTeam = true;
                  });
                },
                child: const Text('Add New Team'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(150, 50),
                ),
              ),
              if (isAddingNewTeam) ...[
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      newTeamName = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Enter New Team Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: addTeam,
                  child: const Text('Submit New Team'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(150, 50),
                  ),
                ),
              ],
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: selectedTeamA != null && selectedTeamB != null && matchDate.isNotEmpty
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PointCounter(
                              teamAName: selectedTeamA!,
                              teamBName: selectedTeamB!,
                              matchDate: matchDate,
                              refereeName: widget.refereeName, // Pass referee name here
                              themeMode: widget.themeMode,
                              toggleTheme: widget.toggleTheme,
                            ),
                          ),
                        );
                      }
                    : null,
                child: const Text('Start Game'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(150, 50),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
