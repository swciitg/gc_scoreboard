import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final theme = ThemeData(
    primaryColor: primaryColor,
    splashColor: primaryColor,
    backgroundColor: backgroundColor,
    cardColor: kGrey,
    focusColor: const Color.fromRGBO(94, 94, 94, 1),
    dividerColor: bottomNavHighlightColor,
    textTheme: TextTheme(
      headline1: GoogleFonts.montserrat(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: kWhite,
      ),
      headline2: GoogleFonts.montserrat(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: bottomNavFontColor,
      ),
      headline3: GoogleFonts.montserrat(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: primaryColor,
      ),
      headline4: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: bottomNavFontColor,
      ),
      headline5: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: cardFontColor4,
      ),
      headline6: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: kWhite,
      ),
      bodyText1: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: bottomNavFontColor,
      ),
      bodyText2: GoogleFonts.montserrat(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: cardFontColor3,
      ),
    ),
  );
  static const kWhite = Color.fromRGBO(242, 242, 242, 1);
  static const kGrey = Color.fromRGBO(71, 71, 71, 1);
  static const backgroundColor = Color.fromRGBO(27, 27, 29, 1);
  static const primaryColor = Color.fromRGBO(118, 172, 255, 1);
  static const secondaryColor = Color.fromRGBO(39, 49, 65, 1);
  static const appbarBackgroundColor = Color.fromRGBO(39, 49, 65, 1);
  static const bottomNavBarColor = Color.fromRGBO(45, 48, 55, 1);
  static const bottomNavFontColor = Color.fromRGBO(171, 171, 175, 1);
  static const bottomNavHighlightColor = Color.fromRGBO(94, 94, 94, 0.38);
  static const cardColor1 = Color.fromRGBO(40, 40, 42, 1);
  static const cardColor2 = Color.fromRGBO(45, 45, 47, 1);
  static const cardFontColor1 = Color.fromRGBO(143, 143, 143, 1);
  static const cardFontColor2 = Color.fromRGBO(242, 242, 242, 1);
  static const cardFontColor3 = Color.fromRGBO(255, 201, 7, 1);
  static const cardFontColor4 = Color.fromRGBO(255, 84, 73, 1);
  static const errorRed = Color(0xFFFF5449);
  static const warning = Color(0xFFFFC907);
}
