import 'package:flutter/material.dart';
import 'package:scoreboard/scoreboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GCScoreBoard(userInfo: {"name" : "Kunal Pal","email" : "k.pal@iitg.ac.in"});
  }
}

