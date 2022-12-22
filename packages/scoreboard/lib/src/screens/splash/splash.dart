import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/routes.dart';
import 'package:scoreboard/src/screens/home.dart';
import 'package:scoreboard/src/stores/user_store.dart';

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
      create: (_) => UserStore(),
      child: Builder(
        builder: (context) => FutureBuilder(
          future: context.read<UserStore>().saveUserData(widget.userInfo,context),
          builder: (context,snapshot){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: snapshot.hasData ? ScoreBoardHome() : WelcomeScreen(),
              routes: routes,
            );
          },
        )
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  static const id = '/welcome';
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

