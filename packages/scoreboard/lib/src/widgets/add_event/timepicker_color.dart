import 'package:flutter/material.dart';

import '../../globals/colors.dart';

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
        backgroundColor: Themes.timePickerBackground,
        dayPeriodBorderSide: const BorderSide(color: Colors.white, width: 2),
        dayPeriodColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? Colors.white
                : Themes.timePickerBackground),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? Colors.blue
                : Colors.blueGrey.shade600),
        dayPeriodShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(width: 4),
        ),
        hourMinuteColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? Colors.white
                : Themes.timePickerDialBackground),
        hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? Colors.blue
                : Colors.white),
        dialHandColor: Colors.blue.shade400,
        dialBackgroundColor: Themes.timePickerDialBackground,
        hourMinuteTextStyle:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        dayPeriodTextStyle:
            const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        helpTextStyle: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
        dialTextColor: MaterialStateColor.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? Colors.black
                : Colors.white),
        entryModeIconColor: Colors.blueGrey.shade600,
      )),
      child: MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          // If you want 24-Hour format, just change alwaysUse24HourFormat to true or remove all the builder argument
          child: widget.childWidget!),
    );
  }
}
