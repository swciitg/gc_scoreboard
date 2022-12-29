import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/globals/helper_variables.dart';
import 'package:scoreboard/src/routes.dart';
import 'package:scoreboard/src/screens/home.dart';
import 'package:scoreboard/src/screens/splash.dart';
import 'package:scoreboard/src/stores/results_form_store.dart';
import 'package:scoreboard/src/stores/user_store.dart';
import 'models/event_model.dart';
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
          create: (_) => UserStore(),
        ),
        Provider<CommonStore>(
          create: (_) => CommonStore(),
        ),
        Provider<ResultsFormStore>(
          create: (_) => ResultsFormStore(
              event: EventModel(
                  event: "Basketball",
                  status: 'ok',
                  venue: "Dihing Basketball Ground",
                  hostels: [],
                  category: "Men",
                  stage: "Finals",
                  date: DateTime.now(), winners: [], resultAdded: false,
              )),
        ),
      ],
      child: Builder(
          builder: (context) => FutureBuilder(
                future: context
                    .read<UserStore>()
                    .saveUserData(widget.userInfo, context),
                builder: (context, snapshot) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: snapshot.hasData
                        ? ScoreBoardHome()
                        : const WelcomeScreen(),
                    routes: routes,
                  );
                },
              )),
    );
  }
}
