import 'package:flutter/material.dart';
import 'package:scoreboard/src/screens/schedule_page.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/models/event_model.dart';
import 'package:scoreboard/src/models/result_model.dart';
import 'package:scoreboard/src/screens/results_form.dart';
import 'package:scoreboard/src/services/api.dart';
import 'package:scoreboard/src/stores/login_store.dart';
import 'package:scoreboard/src/stores/results_form_store.dart';
import 'package:scoreboard/src/widgets/app_bar.dart';

class ScoreBoardHome extends StatefulWidget {
  static const id = '/home';
  const ScoreBoardHome({Key? key}) : super(key: key);

  @override
  State<ScoreBoardHome> createState() => _ScoreBoardHomeState();
}

class _ScoreBoardHomeState extends State<ScoreBoardHome> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
              onPressed: () {
                EventModel e = EventModel(
                    name: "Basketball",
                    category: "Men",
                    stage: "Finals",
                    date: DateTime.now(),
                    results: []);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Provider<ResultsFormStore>(
                            create: (_) => ResultsFormStore(event: e),
                            child: const ResultsForm())));
              },
              child: const Text("Add Result")),
          TextButton(
              onPressed: () {
                ResultModel r1 = ResultModel(
                    position: 1, hostel: "Barak", points: 12, primaryScore: 12);
                ResultModel r2 = ResultModel(
                    position: 1,
                    hostel: "Disang",
                    points: 11,
                    primaryScore: 12,
                    secondaryScore: 10);
                ResultModel r3 = ResultModel(
                    position: 2,
                    hostel: "Brahmaputra",
                    points: 10,
                    primaryScore: 10);
                EventModel e = EventModel(
                    name: "Swimming",
                    category: "Men",
                    stage: "Semi-Finals",
                    date: DateTime.now(),
                    results: [r1, r2, r3]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Provider<ResultsFormStore>(
                            create: (_) => ResultsFormStore(event: e),
                            child: const ResultsForm())));
              },
              child: Text("Edit Result")),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SchedulePage()));
              },
              child: Text("Schedule Page"))
        ],
      ),
    );
  }
}
