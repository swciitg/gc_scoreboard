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
            onPressed: () async {
              final nav = Navigator.of(context);
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('accessToken',
                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NjRmNzhmM2FhZTg2NDIyNzU0YjE2ZjMiLCJpYXQiOjE3MjQwNTc5MDEsImV4cCI6MTcyNDkyMTkwMX0.XMfpKTpTYYE2ozfIvTSWL1dM_CGlTh1H_A6u4C37rD0');
              await prefs.setString('refreshToken',
                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGM3NWM4YWE2ZDE3ZWE0NTYyM2M5ODIiLCJpYXQiOjE3MDc5OTg2ODMsImV4cCI6MTcxMDU5MDY4M30.CjzlhCKI4qIFv4DeTxE8F6tstgOEl6f84EFgT2kV2Ac');

              nav.push(
                MaterialPageRoute(
                  builder: (context) => const GCScoreBoard(userInfo: {
                    "name": "Hardik Roongta",
                    "email": "r.hardik@iitg.ac.in"
                  }),
                ),
              );
            },
            child: const Text("GC SCOREBOARD")),
      ),
    );
  }
}
