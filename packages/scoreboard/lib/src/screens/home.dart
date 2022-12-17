import 'package:flutter/material.dart';
import 'package:scoreboard/src/screens/schedule_page.dart';

class ScoreBoardHome extends StatefulWidget {
  const ScoreBoardHome({Key? key}) : super(key: key);

  @override
  State<ScoreBoardHome> createState() => _ScoreBoardHomeState();
}

class _ScoreBoardHomeState extends State<ScoreBoardHome> {
  @override
  Widget build(BuildContext context) {
    return SchedulePage();
  }
}
