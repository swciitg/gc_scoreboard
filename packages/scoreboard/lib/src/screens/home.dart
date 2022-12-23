import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scoreboard/src/globals/helper_variables.dart';
import 'package:scoreboard/src/screens/add_result_form.dart';
import 'package:scoreboard/src/screens/add_event_form.dart';
import 'package:scoreboard/src/screens/schedule_page.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/screens/standings_page.dart';
import 'package:scoreboard/src/widgets/common/app_bar.dart';
import '../globals/themes.dart';
import '../stores/common_store.dart';
import '../widgets/common/bottom_navigation_bar.dart';

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

  Map<String, Widget> tabs = {
    'Schedule': const SchedulePage(),
    'Standings': const StandingsPage(),
    'Results': const SchedulePage(),
  };

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Observer(
      builder: (context) {
        return Scaffold(
          backgroundColor: Themes.backgroundColor,
          appBar: appBar(context, viewType.user),
          body: tabs[commonStore.page],
          bottomNavigationBar: const BottomNavBar(),
          floatingActionButton: commonStore.page == 'Schedule'
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddEventForm()));
                  },
                  child:
                      Container(height: 15, width: 100,color: Colors.blue ,child: Center(child: const Text('Add Event'))),
                )
              : commonStore.page == 'Results'?
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddResultForm()));
            },
            child:
            Container(height: 15, width: 100,color: Colors.blue ,child: Center(child: const Text('Add Result'))),
          )
              :Container(),
        );
      },
    );
  }
}

// Scaffold(
// appBar: appBar(context,viewType.user),
// body: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// TextButton(
// onPressed: () {
// EventModel e = EventModel(
// name: "Basketball",
// group: "Basketball",
// venue: "Dihing Basketball Ground",
// hostels: [],
// category: "Men",
// stage: "Finals",
// date: DateTime.now(),
// results: []);
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Provider<ResultsFormStore>(
// create: (_) => ResultsFormStore(event: e),
// child: const ResultsForm())));
// },
// child: const Text("Add Result")),
// TextButton(
// onPressed: () {
// ResultModel r1 = ResultModel(
// position: 1, hostel: "Barak", points: 12, primaryScore: 12);
// ResultModel r2 = ResultModel(
// position: 1,
// hostel: "Disang",
// points: 11,
// primaryScore: 12,
// secondaryScore: 10);
// ResultModel r3 = ResultModel(
// position: 2,
// hostel: "Brahmaputra",
// points: 10,
// primaryScore: 10);
// EventModel e = EventModel(
// name: "Swimming",
// category: "Men",
// stage: "Semi-Finals",
// venue: "Swimming Pool",
// hostels: [],
// group: "Aquatics",
// date: DateTime.now(),
// results: [r1, r2, r3]);
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Provider<ResultsFormStore>(
// create: (_) => ResultsFormStore(event: e),
// child: const ResultsForm())));
// },
// child: Text("Edit Result")),
// TextButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => const SchedulePage()));
// },
// child: Text("Schedule Page")),
// TextButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => const ScheduleEvent()));
// },
// child: Text("Add Event")),
// TextButton(
// onPressed: () {
// EventModel e = EventModel(
// name: "Swimming",
// // category: "Men",
// category: "Athletics",
// // stage: "Semi-Finals",
// stage: "Football",
// venue: "Swimming Pool",
// hostels: [],
// group: "Aquatics",
// date: DateTime.now(),
// results: []);
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => ScheduleEvent(event: e,)));
// },
// child: Text("Edit Event")),
// TextButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => const StandingsPage()));
// },
// child: Text("Scoreboard Page")),
//
// ],
// ),
// );
