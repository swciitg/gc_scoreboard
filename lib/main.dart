import 'package:flutter/material.dart';
import 'package:scoreboard/scoreboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SampleHome(),
      );
  }
}

class SampleHome extends StatelessWidget {
  const SampleHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GCScoreBoard(userInfo: {
                    "name": "Kunal Pal",
                    "email": "k.pal@iitg.ac.in"
                  })));
            },
            child: Text("GC SCOREBOARD")),
      ),
    );
  }
}
