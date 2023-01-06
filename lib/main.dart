import 'package:flutter/material.dart';
import 'package:scoreboard/scoreboard.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GCScoreBoard(userInfo: {"name" : "Nandigrama Naga Venkata Hareesh","email" : "h.nandigrama@iitg.ac.in"});
  }
}

