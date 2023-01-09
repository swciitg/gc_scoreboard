import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../globals/styles/card_style.dart';


class DateWidget extends StatelessWidget {
  final DateTime date;
  const DateWidget({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/date.svg',
          package: 'scoreboard',
        ),
        Padding(
          padding:
          const EdgeInsets.fromLTRB(8, 34, 8, 0),
          child: Container(
            alignment: Alignment.center,
            height: 28,
            width: 66,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.d()
                      .format(date),
                  style: dateWidgetStyle,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  DateFormat.LLL()
                      .format(date),
                  style: dateWidgetStyle,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}