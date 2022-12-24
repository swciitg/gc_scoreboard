import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../widgets/cards/schedule_card.dart';
import '../widgets/schedule_page/filter_bar.dart';
import '../widgets/common/top_bar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  EventModel eventModel = EventModel(
      name: 'Badminton Doubles',
      group: 'Athletics',
      category: 'Men',
      stage: 'Quarter-Final',
      date: DateTime.now(),
      venue: 'Table Tennis Court, Old SAC',
      results: [],
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
      ]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(),
            const FilterBar(),
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
      ),
    );
  }
}
