import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../widgets/cards/schedule_card.dart';
import '../widgets/common/filter_bar.dart';
import '../widgets/common/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/stores/common_store.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final TextEditingController sport = TextEditingController(text: "Overall");
  final TextEditingController hostel = TextEditingController(text: "Overall");
  final TextEditingController category = TextEditingController(text: "Overall");

  EventModel eventModel = EventModel(
      event: 'Badminton Doubles',
      category: 'Men',
      stage: 'Quarter-Final',
      date: DateTime.now(),
      venue: 'Table Tennis Court, Old SAC',
      hostels: [
        'Married Scholars',
        'Brahmaputra',
        'Married Scholars',
        // 'Brahmaputra',
        // 'Married Scholars',
        // 'Brahmaputra',
        // 'Married Scholars',
        // 'Brahmaputra',
        // 'Married Scholars',
        // 'Brahmaputra',
        // 'Married Scholars',
        // 'Brahmaputra',
        // 'Married Scholars',
        // 'Brahmaputra',
      ], status: 'ok', winners: []);

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        child: Column(
          children: [
            const TopBar(),
            FilterBar(
              sport: sport,
              hostel: hostel,
              category: category,
              screen: 'schedule',
            ),
            Expanded(
              child: ListView(
                children: [
                  ScheduleCard(
                    eventModel: eventModel,
                    status: '',
                  ),
                  ScheduleCard(
                    eventModel: eventModel,
                    status: 'postponed',
                  ),
                  ScheduleCard(
                    eventModel: eventModel,
                    status: 'cancelled',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
