import 'package:flutter/material.dart';
import 'package:scoreboard/src/screens/add_results_screen.dart';

class ScoreBoardHome extends StatefulWidget {
  const ScoreBoardHome({Key? key}) : super(key: key);

  @override
  State<ScoreBoardHome> createState() => _ScoreBoardHomeState();
}

class _ScoreBoardHomeState extends State<ScoreBoardHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddResult()));
              },
              child: Text("Add Result"))
        ],
      ),
    );
  }
}
