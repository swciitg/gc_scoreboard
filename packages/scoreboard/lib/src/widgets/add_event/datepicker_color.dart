import 'package:flutter/material.dart';

import '../../globals/colors.dart';
import '../../globals/styles.dart';

class DatePickerTheme extends StatefulWidget {
  final Widget? child;
  const DatePickerTheme({super.key, this.child});

  @override
  State<DatePickerTheme> createState() => _DatePickerThemeState();
}

class _DatePickerThemeState extends State<DatePickerTheme> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: TextTheme(
          headline4: basicFontStyle,
          headline5: basicFontStyle, // Selected Date landscape
          headline6: basicFontStyle, // Selected Date portrait
          overline: basicFontStyle, // Title - SELECT DATE
          bodyText1: basicFontStyle, // year gridbview picker
          bodyText2: basicFontStyle, // year gridbview picker
          subtitle1: basicFontStyle, // input
          subtitle2: basicFontStyle, // month/year picker
          caption: basicFontStyle, // days
        ),
        colorScheme: const ColorScheme.dark(
          primary: Themes.datePickerPrimaryColor,
          onPrimary: Colors.black,
          onSurface: Colors.white,
          surface: Themes.datePickerSurfaceColor,
        ),
        dialogBackgroundColor: Themes.datePickerSurfaceColor,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: Themes.datePickerSurfaceColor, // button
              foregroundColor: Themes.primaryColor,
              elevation: 0,
              textStyle: basicFontStyle),
        ),
      ),
      child: widget.child!,
    );
  }
}
