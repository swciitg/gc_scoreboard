import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/routes.dart';
import 'package:scoreboard/src/screens/home.dart';
import 'package:scoreboard/src/screens/splash.dart';
import 'package:scoreboard/src/stores/user_store.dart';
import 'functions/auth_user_helper.dart';
import 'stores/common_store.dart';

class GCScoreBoard extends StatefulWidget {
  Map<String, String> userInfo;
  GCScoreBoard({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<GCScoreBoard> createState() => _GCScoreBoardState();
}

class _GCScoreBoardState extends State<GCScoreBoard> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => SpardhaStore(),
        ),
        Provider<CommonStore>(
          create: (_) => CommonStore(),
        )
      ],
      child: Builder(
          builder: (buildContext) => FutureBuilder(
                future: AuthUserHelpers.saveUserData(widget.userInfo, buildContext),
                builder: (buildContext, snapshot) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: snapshot.hasData
                        ? const ScoreBoardHome()
                        : const WelcomeScreen(),
                    routes: routes,
                  );
                },
              )),
    );
  }
}
