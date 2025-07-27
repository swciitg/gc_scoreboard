import 'package:flutter/material.dart';
import 'package:scoreboard/scoreboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TextButton(
            onPressed: () async {
              final nav = Navigator.of(context);
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('accessToken',
                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NjQ0YzE1NTZiZWMxMGE3NjRmMGFkYTEiLCJpYXQiOjE3Mzc3MjQ4NzUsImV4cCI6MTczODU4ODg3NX0.pCgvGGENMWwGklnyxTARBQLfHy06tKQh7gAVfULhxeE');
              await prefs.setString('refreshToken',
                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NjQ0YzE1NTZiZWMxMGE3NjRmMGFkYTEiLCJpYXQiOjE3Mzc3MjQ4NzUsImV4cCI6MTc0MDMxNjg3NX0.aBqrowjTfMqjDVhpWvc2GXkakLLi78eftOP5wP6tCZ8');

              nav.push(
                MaterialPageRoute(
                  builder: (context) => const GCScoreBoard(userInfo: {
                    "name": "Amit Singh",
                    "email": "amitsingh.cl@iitg.ac.in"
                  }),
                ),
              );
            },
            child: const Text("GC SCOREBOARD")),
      ),
    );
  }
}
