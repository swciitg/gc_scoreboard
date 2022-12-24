import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scoreboard/src/widgets/schedule_page/filter_bar.dart';
import 'package:scoreboard/src/widgets/common/top_bar.dart';


class SchedulePage extends StatefulWidget {
  final String? category;
  const SchedulePage({Key? key, required this.category}) : super(key: key);

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
            emptyState(widget.category.toString()),
          ],
        ),
      );
  }


  Widget emptyState(String category) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 100),
      child: SizedBox(
        height: 230,
        width: 220,
        child:
        category == 'schedule'
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
