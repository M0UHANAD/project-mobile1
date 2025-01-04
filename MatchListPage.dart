import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MatchListPage extends StatefulWidget {
  @override
  _MatchListPageState createState() => _MatchListPageState();
}

class _MatchListPageState extends State<MatchListPage> {
  late Future<List<dynamic>> matchesFuture;

  Future<List<dynamic>> fetchMatches() async {
    try {
      final url = Uri.parse('http://osmanrmd.atwebpages.com/main.php');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'action': 'fetch_matches'}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return data['matches'];
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to load matches');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  @override
  void initState() {
    super.initState();
    matchesFuture = fetchMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saved Matches',
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
      body: FutureBuilder<List<dynamic>>(
        future: matchesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No matches found.'));
          } else {
            final matches = snapshot.data!;
            return ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  elevation: 5, // Shadow effect
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    title: Text(
                      '${match['team1']} vs ${match['team2']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    subtitle: Text(
                      'Score: ${match['score_team1']} - ${match['score_team2']}\n'
                      'Referee: ${match['referee_name']}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.5, // Line height for better readability
                      ),
                    ),
                    isThreeLine: true,
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Text(
                        '${match['score_team1']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.sports_basketball,
                      color: Colors.orange,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
