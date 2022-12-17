import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/models/event_model.dart';
import 'package:scoreboard/src/screens/add_results_screen.dart';
import 'package:scoreboard/src/stores/counter.dart';

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
                        builder: (context) => Provider<CounterStore>(
                            create: (_) => CounterStore(event: e),
                            child: AddResult())));
              },
              child: Text("Add Result"))
        ],
      ),
    );
  }
}
