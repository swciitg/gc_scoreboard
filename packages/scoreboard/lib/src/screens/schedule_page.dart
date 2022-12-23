import 'package:flutter/material.dart';
import 'package:scoreboard/src/widgets/schedule_page/filter_bar.dart';
import 'package:scoreboard/src/widgets/common/top_bar.dart';


class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            TopBar(),
            const FilterBar(),
          ],
        ),
      );
  }
}
