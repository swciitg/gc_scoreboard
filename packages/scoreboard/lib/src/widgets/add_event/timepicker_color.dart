import 'package:flutter/material.dart';

import '../../globals/colors.dart';
import '../../globals/styles.dart';

class TimePickerColor extends StatefulWidget {
  final Widget? childWidget;
  const TimePickerColor({super.key, required this.childWidget});

  @override
  State<TimePickerColor> createState() => _TimePickerColorState();
}

class _TimePickerColorState extends State<TimePickerColor> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Themes.secondaryColor,
          dayPeriodBorderSide:
              const BorderSide(color: Themes.dayPeriodBorderColor, width: 2),
          dayPeriodColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? Themes.dayPeriodBorderColor
                  : Themes.secondaryColor),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? Colors.white
                  : Colors.blueGrey.shade600),
          dayPeriodShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(width: 4),
          ),
          hourMinuteColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? Themes.dayPeriodBorderColor
                  : Themes.datePickerSurfaceColor),
          hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? Colors.white
                  : Colors.white),
          dialHandColor: Themes.primaryColor,
          dialBackgroundColor: Themes.datePickerSurfaceColor,
          hourMinuteTextStyle: hourMinuteStyle,
          dayPeriodTextStyle: dayPeriodStyle,
          helpTextStyle: helptextStyle,
          dialTextColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? Colors.black
                  : Colors.white),
          entryModeIconColor: Colors.blueGrey.shade600,
        ),
        textTheme: TextTheme(
          caption: basicFontStyle, // days
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: Themes.secondaryColor, // button
              foregroundColor: Themes.primaryColor,
              elevation: 0,
              textStyle: basicFontStyle),
        ),
      ),
      child: MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          // If you want 24-Hour format, just change alwaysUse24HourFormat to true or remove all the builder argument
          child: widget.childWidget!),
    );

  }
}
