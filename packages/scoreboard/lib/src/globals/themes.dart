import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final theme = ThemeData(
    primaryColor: const Color.fromRGBO(118, 172, 255, 1),
    splashColor: const Color.fromRGBO(118, 172, 255, 1),
    backgroundColor: const Color.fromRGBO(27, 27, 29, 1),
    cardColor: const Color.fromRGBO(71, 71, 71, 1),
    focusColor: const Color.fromRGBO(94, 94, 94, 1),
    dividerColor: const Color.fromRGBO(94, 94, 94, 0.38),
    textTheme: TextTheme(
      headline1: GoogleFonts.montserrat(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: const Color.fromRGBO(242, 242, 242, 1),
      ),
      headline2: GoogleFonts.montserrat(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: const Color.fromRGBO(171, 171, 175, 1),
      ),
      headline3: GoogleFonts.montserrat(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: const Color.fromRGBO(118, 172, 255, 1),
      ),
      headline4: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: const Color.fromRGBO(171, 171, 175, 1),
      ),
      headline5: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: const Color.fromRGBO(255, 84, 73, 1),
      ),
      headline6: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: const Color.fromRGBO(242, 242, 242, 1),
      ),
      bodyText1: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: const Color.fromRGBO(171, 171, 175, 1),
      ),
      bodyText2: GoogleFonts.montserrat(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: const Color.fromRGBO(255, 201, 7, 1),
      ),
    ),
  );

  static const backgroundColor = Color.fromRGBO(27, 27, 29, 0);
  static const primaryColor = Color.fromRGBO(118, 172, 255, 1);
  static const secondaryColor = Color.fromRGBO(39, 49, 65, 1);
  static const appbarBackgroundColor = Color.fromRGBO(39, 49, 65, 1);
  static const bottomNavBarColor = Color.fromRGBO(45, 48, 55, 1);
  static const bottomNavFontColor = Color.fromRGBO(171, 171, 175, 1);
  static const bottomNavHighlightColor = Color.fromRGBO(94, 94, 94, 0.38);
  static const cardColor = Color.fromRGBO(40, 40, 42, 1);
  static const dotColor = Color.fromRGBO(255, 201, 7, 1);
  static const cardFontColor1 = Color.fromRGBO(143, 143, 143, 1);
  static const cardFontColor2 = Color.fromRGBO(242, 242, 242, 1);
}
