import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/models/event_model.dart';
import 'package:scoreboard/src/screens/results_form.dart';
import 'package:scoreboard/src/stores/results_form_store.dart';

class ScoreBoardHome extends StatefulWidget {
  const ScoreBoardHome({Key? key}) : super(key: key);

  @override
  State<ScoreBoardHome> createState() => _ScoreBoardHomeState();
}

class _ScoreBoardHomeState extends State<ScoreBoardHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
              child: const Text("Add Result"))
        ],
      ),
    );
  }
}
