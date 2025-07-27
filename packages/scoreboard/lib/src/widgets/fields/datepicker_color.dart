import 'package:flutter/material.dart';

import '../../globals/colors.dart';
import '../../globals/styles.dart';

class CustomDatePicker extends StatefulWidget {
  final Widget? child;

  const CustomDatePicker({super.key, this.child});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: const TextTheme(
          headlineLarge: basicFontStyle,
          headlineMedium: basicFontStyle,
          // Selected Date landscape
          headlineSmall: basicFontStyle,
          // Selected Date portrait
          titleMedium: basicFontStyle,
          // Title - SELECT DATE
          bodyLarge: basicFontStyle,
          // year gridbview picker
          bodyMedium: basicFontStyle,
          // input
          bodySmall: basicFontStyle,
          // month/year picker
          labelLarge: basicFontStyle, // days
        ),
        colorScheme: const ColorScheme.dark(
          primary: Themes.datePickerPrimaryColor,
          surface: Themes.datePickerSurfaceColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: Themes.datePickerSurfaceColor, // button
              foregroundColor: Themes.primaryColor,
              elevation: 0,
              textStyle: basicFontStyle),
        ), dialogTheme: DialogThemeData(backgroundColor: Themes.datePickerSurfaceColor),
      ),
      child: widget.child!,
    );
  }
}
