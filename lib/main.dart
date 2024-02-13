import 'package:flutter/material.dart';
import 'package:scoreboard/scoreboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            onPressed: () async{
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('accessToken', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGM3NWM4YWE2ZDE3ZWE0NTYyM2M5ODIiLCJpYXQiOjE3MDc4Mjc4OTIsImV4cCI6MTcwODY5MTg5Mn0.SQMHtnQTlpi-EdBR9KIycFiAqWTq-qOCyS5JBoLOHl0');
              await prefs.setString('refreshToken', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGM3NWM4YWE2ZDE3ZWE0NTYyM2M5ODIiLCJpYXQiOjE3MDc4Mjc4OTIsImV4cCI6MTcxMDQxOTg5Mn0.ONoYmhqEuL3RptfyEPHc38shSAyN6niMK8HsC8C_d0g');
              print('****************************Tokens set*************************');
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
