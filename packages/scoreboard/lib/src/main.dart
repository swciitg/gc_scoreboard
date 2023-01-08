import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/routes.dart';
import 'package:scoreboard/src/screens/home.dart';
import 'package:scoreboard/src/screens/splash.dart';
import 'package:scoreboard/src/stores/gc_store.dart';
import 'package:scoreboard/src/stores/kriti_store.dart';
import 'package:scoreboard/src/stores/manthan_store.dart';
import 'package:scoreboard/src/stores/spardha_store.dart';
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
        Provider<CommonStore>(
          create: (_) => CommonStore(),
        ),
        Provider<GCStore>(
          create: (_) => GCStore(),
        ),
        Provider<SpardhaStore>(
          create: (_) => SpardhaStore(),
        ),
        Provider<KritiStore>(
          create: (_) => KritiStore(),
        ),
        Provider<ManthanStore>(
          create: (_) => ManthanStore(),
        ),
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
