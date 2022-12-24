import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../widgets/cards/schedule_card.dart';
import '../widgets/schedule_page/filter_bar.dart';
import '../widgets/common/top_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/stores/common_store.dart';
import 'package:scoreboard/src/widgets/schedule_page/filter_bar.dart';
import 'package:scoreboard/src/widgets/common/top_bar.dart';


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
    var commonStore = context.read<CommonStore>();
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


  Widget emptyState(String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: SizedBox(
        height: 230,
        width: 220,
        child:
        category == 'Schedule'
            ? SvgPicture.asset(
          'assets/no_schedule.svg',
          package: 'scoreboard',
        )
            : SvgPicture.asset(
          'assets/no_result.svg',
          package: 'scoreboard',
        ),
      ),
    );
  }
}
