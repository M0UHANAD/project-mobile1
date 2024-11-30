import 'package:flutter/material.dart';

void main() {
  runApp(pointCounter());
}

class pointCounter extends StatefulWidget {
  @override
  State<pointCounter> createState() => _pointCounterState();
}

class _pointCounterState extends State<pointCounter> {
  int TeamAPoints = 0;

  int TeamBPoints = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          title: const Text('Points Counter'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Team A',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      '$TeamAPoints',
                      style: TextStyle(fontSize: 140),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            TeamAPoints++;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.orange),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          minimumSize: WidgetStatePropertyAll(Size(150, 60)),
                        ),
                        child: Text(
                          'Add 1 point',
                          style: TextStyle(fontSize: 22),
                        )),
                    SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            TeamAPoints += 2;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.orange),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          minimumSize: WidgetStatePropertyAll(Size(150, 60)),
                        ),
                        child: Text(
                          'Add 2 points',
                          style: TextStyle(fontSize: 20),
                        )),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          TeamAPoints += 3;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.orange),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                        minimumSize: WidgetStatePropertyAll(Size(150, 60)),
                      ),
                      child: Text(
                        'Add 3 points',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 460,
                  child: VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 8,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Team B',
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      '$TeamBPoints',
                      style: TextStyle(fontSize: 140),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            TeamBPoints++;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.orange),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          minimumSize: WidgetStatePropertyAll(Size(150, 60)),
                        ),
                        child: Text(
                          'Add 1 point',
                          style: TextStyle(fontSize: 22),
                        )),
                    SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            TeamBPoints += 2;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.orange),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          minimumSize: WidgetStatePropertyAll(Size(150, 60)),
                        ),
                        child: Text(
                          'Add 2 points',
                          style: TextStyle(fontSize: 20),
                        )),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          TeamBPoints += 3;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.orange),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                        minimumSize: WidgetStatePropertyAll(Size(150, 60)),
                      ),
                      child: Text(
                        'Add 3 points',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  TeamBPoints = 0;
                  TeamAPoints = 0;
                });
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.orange),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                minimumSize: WidgetStatePropertyAll(Size(150, 60)),
              ),
              child: Text(
                'Reset',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
