import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../globals/styles.dart';

class DateWidget extends StatelessWidget {
  final DateTime date;
  const DateWidget({super.key, required this.date});

  static final _whiteeDateStyle = dateWidgetStyle.copyWith(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82,
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/date.svg',
            package: 'scoreboard',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 34, 8, 0),
            child: Container(
              alignment: Alignment.center,
              height: 28,
              width: 66,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.d().format(date),
                    style: _whiteeDateStyle,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    DateFormat.LLL().format(date),
                    style: _whiteeDateStyle,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
