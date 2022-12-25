import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyState extends StatelessWidget {
  final String category;
  const EmptyState({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100),
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
