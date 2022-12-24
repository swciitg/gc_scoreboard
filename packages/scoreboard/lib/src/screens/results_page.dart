import 'package:flutter/material.dart';
import 'package:scoreboard/src/models/result_model.dart';

import '../widgets/cards/results_card.dart';
import '../models/event_model.dart';
import '../widgets/common/top_bar.dart';
import '../widgets/schedule_page/filter_bar.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  EventModel eventModel = EventModel(
      name: 'Cricket',
      group: 'Athletics',
      category: 'Men',
      stage: 'Quarter-Final',
      date: DateTime.now(),
      venue: 'Table Tennis Court, Old SAC',
      results: [
        ResultModel(
            position: 1, hostel: 'Disang', points: 1, primaryScore: '22.1s'),
        ResultModel(
            position: 2, hostel: 'Lohit', points: 1, primaryScore: '23.1s'),
        ResultModel(
            position: 3, hostel: 'Kameng', points: 1, primaryScore: '24.1s'),
        ResultModel(
            position: 4, hostel: 'Umiam', points: 1, primaryScore: '25.1s'),
        ResultModel(
            position: 5,
            hostel: 'Brahmaputra',
            points: 1,
            primaryScore: '26.1s'),
      ],
      hostels: [
        'Disang',
        'Lohit',
        'Kameng',
        'Umiam',
        'Brahmaputra',
      ]);
  EventModel eventModel2 = EventModel(
      name: 'Cricket',
      group: 'Athletics',
      category: 'Men',
      stage: 'Quarter-Final',
      date: DateTime.now(),
      venue: 'Table Tennis Court, Old SAC',
      results: [
        ResultModel(
            position: 1,
            hostel: 'Disang',
            points: 1,
            primaryScore: '22.1s',
            secondaryScore: '12,22,32,11'),
        ResultModel(
            position: 2,
            hostel: 'Lohit',
            points: 1,
            primaryScore: '23.1s',
            secondaryScore: '13,23,33,32'),
      ],
      hostels: [
        'Disang',
        'Lohit',
        'Kameng',
        'Umiam',
        'Brahmaputra',
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
            ResultsCard(
              eventModel: eventModel,
              isTie: false,
            ),
            ResultsCard(
              eventModel: eventModel2,
              isTie: true,
            )
          ],
        ),
      ),
    );
  }
}
