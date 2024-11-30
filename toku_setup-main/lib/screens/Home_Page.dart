import 'package:flutter/material.dart';
import 'package:toku/screens/Colors.dart';
import 'package:toku/screens/Phrases.dart';
import 'package:toku/screens/familymember_page.dart';
import 'package:toku/screens/numbers_page.dart';

import '../components/category_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFEF6DB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF46322B),
        title: const Text(
          'Toku',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Category(
            text: 'Numbers',
            color: Colors.orangeAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return NumbersPage();
                  },
                ),
              );
            },
          ),
          Category(
            text: 'Family Member',
            color: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return FamilyMember();
                  },
                ),
              );
            },
          ),
          Category(
            onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ColorPage();
                  },
                ),
              );
            },
            text: 'Colors',
            color: Colors.purple,
          ),
          Category(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return PhrasesPage();
                  },
                ),
              );
            },
            text: 'Phrases',
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
