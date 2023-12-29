import 'package:flutter/material.dart';
import 'package:scoreboard/scoreboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;
    return const MaterialApp(
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
                  builder: (context) => const GCScoreBoard(userInfo:  {
                    "name": "Hardik Roongta",
                    "email": "r.hardik@iitg.ac.in"
                  })));
            },
            child: const Text("GC SCOREBOARD")),
      ),
    );
  }
}
