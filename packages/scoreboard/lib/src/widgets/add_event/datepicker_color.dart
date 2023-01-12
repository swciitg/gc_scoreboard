import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


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
            headline4:
            GoogleFonts.montserrat(),
            headline5: GoogleFonts
                .montserrat(), // Selected Date landscape
            headline6: GoogleFonts
                .montserrat(), // Selected Date portrait
            overline: GoogleFonts
                .montserrat(), // Title - SELECT DATE
            bodyText1: GoogleFonts
                .montserrat(), // year gridbview picker
            bodyText2: GoogleFonts
                .montserrat(), // year gridbview picker
            subtitle1: GoogleFonts
                .montserrat(), // input
            subtitle2: GoogleFonts
                .montserrat(), // month/year picker
            caption: GoogleFonts
                .montserrat(), // days
          ),
          colorScheme: ColorScheme.dark(
            primary: Color.fromRGBO(189, 199, 220, 1),
            onPrimary: Colors.black,
            onSurface: Colors.white,
            surface: const Color(0xff2B3E5C),
          ),
          dialogBackgroundColor:
          const Color(0xff2B3E5C),
          textButtonTheme:
          TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor:
                const Color(0xff2B3E5C), // button
                foregroundColor: Color.fromRGBO(118, 172, 255, 1),
                elevation: 0,
                textStyle:
                GoogleFonts.montserrat()),
          ),
        ),
        child: widget.child!,
      );
  }
}