import 'package:flutter/material.dart';
import '../models/result_model.dart';
import '../widgets/cards/results_card.dart';
import '../models/event_model.dart';
import '../widgets/common/top_bar.dart';
import '../widgets/common/filter_bar.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final TextEditingController sport = TextEditingController(text: "Overall");
  final TextEditingController hostel = TextEditingController(text: "Overall");
  final TextEditingController category = TextEditingController(text: "Overall");

  EventModel eventModel = EventModel(
    victoryStatement: 'Disang won',
      event: 'Cricket',
      category: 'Men',
      stage: 'Quarter-Final',
      date: DateTime.now(),
      venue: 'Table Tennis Court, Old SAC',
      results: [
        [ResultModel(
             hostel: 'Disang', points: 1, primaryScore: '22.1s')],
        [ResultModel(
             hostel: 'Lohit', points: 1, primaryScore: '23.1s')],
        [ResultModel(
             hostel: 'Kameng', points: 1, primaryScore: '24.1s')],
        [ResultModel(
             hostel: 'Umiam', points: 1, primaryScore: '25.1s')],
        [ResultModel(

            hostel: 'Brahmaputra',
            points: 1,
            primaryScore: '26.1s')],
      ],
      hostels: [
        'Disang',
        'Lohit',
        'Kameng',
        'Umiam',
        'Brahmaputra',
      ], status: 'ok', resultAdded: false);

  EventModel eventModel2 = EventModel(
    victoryStatement: 'Tie between Disang and Lohit',
      event: 'Cricket',
      category: 'Men',
      stage: 'Quarter-Final',
      date: DateTime.now(),
      venue: 'Table Tennis Court, Old SAC',
      results: [
        [ResultModel(

            hostel: 'Disang',
            points: 1,
            primaryScore: '.1s',
            secondaryScore: '1,2,3,1',)],
        [ResultModel(

            hostel: 'Lohit',
            points: 1,
            primaryScore: '23.1s',
            secondaryScore: '13,23,33,32')],
      ],
      hostels: [
        'Disang',
        'Lohit',
        'Kameng',
        'Umiam',
        'Brahmaputra',
      ], status: 'ok', resultAdded: false);

  @override
  Widget build(BuildContext context) {
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
              screen: 'results',
            ),
            Expanded(
              child: ListView(
                children: [
                  ResultsCard(
                    eventModel: eventModel,
                  ),
                  ResultsCard(
                    eventModel: eventModel2,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
