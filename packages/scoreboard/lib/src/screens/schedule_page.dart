import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/stores/common_store.dart';
import '../models/event_model.dart';
import '../widgets/cards/schedule_card.dart';
import '../widgets/common/filter_bar.dart';
import '../widgets/common/top_bar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {

  EventModel eventModel = EventModel(
      event: 'Badminton Doubles',
      category: 'Men',
      stage: 'Quarter-Final',
      date: DateTime.now(),
      venue: 'Table Tennis Court, Old SAC',
      hostels: [
        'Married Scholars',
        'Brahmaputra',
      ], status: 'ok', results: [], resultAdded: false);

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            child: Column(
              children: [
                const TopBar(),
                FilterBar(),
                Expanded(
                  child: ListView(
                    children: [
                      ScheduleCard(
                        eventModel: eventModel,
                      ),
                      ScheduleCard(
                        eventModel: eventModel,
                      ),
                      ScheduleCard(
                        eventModel: eventModel,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
