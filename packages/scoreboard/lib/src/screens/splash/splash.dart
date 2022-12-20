import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/screens/home.dart';
import 'package:scoreboard/src/stores/login_store.dart';

class ScoreboardSplashScreen extends StatefulWidget {
  Map<String,String> userInfo;
  ScoreboardSplashScreen({Key? key,required this.userInfo}) : super(key: key);

  @override
  State<ScoreboardSplashScreen> createState() => _ScoreboardSplashScreenState();
}

class _ScoreboardSplashScreenState extends State<ScoreboardSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => LoginStore(),
      child: Builder(
        builder: (context) => FutureBuilder(
          future: context.read<LoginStore>().saveUserData(widget.userInfo),
          builder: (context,snapshot){
            return MaterialApp(
              home: snapshot.hasData ? ScoreBoardHome() : WelcomeScreen(),
            );
          },
        )
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

