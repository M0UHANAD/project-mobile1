import 'package:flutter/material.dart';

void main() {
  runApp(BusniessCardApp());
}

// ignore: must_be_immutable
class BusniessCardApp extends StatelessWidget {
  BusniessCardApp({Key? key}) : super(key: key);
  double radius = 112;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF3397ae),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 112,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 110,
                  backgroundImage: AssetImage('images/businessCard.jpeg'),
                ),
              ),
              const Text(
                'Mouhanad Moussa',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: 'Pacifico',
                ),
              ),
              const Text(
                'FUTTER DEVELOPPER',
                style: TextStyle(
                    color: Color(0xFF6C8090),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const Divider(thickness: 2, indent: 60, endIndent: 60),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Icon(
                          Icons.phone,
                          size: 30,
                          color: Color(0xFF3397ae),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          '(+961) 76 095 023',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.mail,
                          size: 30,
                          color: Color(0xFF3397ae),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'mouhanadmoussa55@gmail.com',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
