import 'package:flutter/material.dart';
import 'package:onestop_ui/index.dart';

import 'colors.dart';

const _font = 'Geist';

BoxDecoration get boxDecoration => BoxDecoration(
    borderRadius: BorderRadius.circular(OCornerRadius.l), color: Themes.cardColor1);

Icon get popUpIcon => Icon(
  Icons.unfold_more_outlined,
  size: 20,
  color: Themes.cardFontColor1,
);

TextStyle get headingStyle1 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600, fontSize: 22, color: Themes.primaryColor);

TextStyle get headingStyle2 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500, fontSize: 22, color: Themes.warning);

TextStyle get popUpHeadingStyle => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600, fontSize: 10, color: Themes.cardFontColor1);

TextStyle get popUpItemStyle => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600, fontSize: 12, color: Themes.cardFontColor2);

TextStyle get dateWidgetStyle => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w700, fontSize: 16, color: Themes.cardFontColor2);

TextStyle get cardEventStyle => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w700, fontSize: 16, color: Themes.cardFontColor2);

TextStyle get standingsHeadingStyle => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500, fontSize: 16, color: Themes.cardFontColor2);

TextStyle get cardCategoryStyle => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Themes.primaryColor);

TextStyle get bottomNavStyle1 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: Themes.bottomNavFontColor);

TextStyle get bottomNavStyle2 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: Themes.bottomNavFontColor);

TextStyle get cardStageStyle1 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600, fontSize: 12, color: Themes.warning);

TextStyle get cardStageStyle2 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600, fontSize: 12, color: Themes.primaryColor);

TextStyle get cardStageStyle3 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600, fontSize: 12, color: OColor.gray800);

TextStyle get cardVenueStyle1 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500, fontSize: 12, color: Themes.cardFontColor2);

TextStyle get cardVenueStyle2 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600, fontSize: 12, color: Themes.cardFontColor2);

TextStyle get cardVenueStyle3 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600, fontSize: 14, color: Themes.cardFontColor2);

TextStyle get cardResultStyle1 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500, fontSize: 10, color: Themes.cardFontColor2);

TextStyle get cardResultStyle2 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600,
    fontSize: 10,
    color: Themes.bottomNavFontColor);

TextStyle get cardSecondaryScoreStyle => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500, fontSize: 12, color: Themes.cardFontColor1);

TextStyle get cardPostponedStyle => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500, fontSize: 12, color: Themes.warning);

TextStyle get cardCancelledStyle => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600, fontSize: 12, color: Themes.errorRed);

TextStyle get cardTimeStyle => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500, fontSize: 12, color: Themes.cardFontColor2);

const basicFontStyle = TextStyle(
  fontFamily: _font,
);

TextStyle get fontStyle1 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600, fontSize: 12, color: Themes.cardFontColor2);

TextStyle get fontStyle3 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w700, fontSize: 14, color: Themes.cardFontColor2);

TextStyle get fontStyle2 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w700, fontSize: 16, color: Themes.cardFontColor2);

const buttonStyle =
TextStyle(
    fontFamily: _font, fontSize: 15, fontWeight: FontWeight.w600);

// dateTimePickerStyles

const hourMinuteStyle = TextStyle(
  fontFamily: _font,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const dayPeriodStyle =
TextStyle(
    fontFamily: _font, fontSize: 12, fontWeight: FontWeight.bold);

TextStyle get helptextStyle => TextStyle(
    fontFamily: _font,
    fontSize: 12, fontWeight: FontWeight.bold, color: OColor.gray800);

// standingBoardStyles

// text themes
TextStyle get standingStyle1 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w700, fontSize: 13, color: Themes.cardFontColor2);

TextStyle get standingStyle2 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600, fontSize: 13, color: Themes.cardFontColor2);

TextStyle get headline1 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w700, fontSize: 16, color: Themes.cardFontColor2);

TextStyle get headline2 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600, fontSize: 14, color: Themes.bottomNavFontColor);

TextStyle get headline3 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600, fontSize: 12, color: Themes.primaryColor);

TextStyle get headline4 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500, fontSize: 12, color: Themes.bottomNavFontColor);

TextStyle get headline5 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500, fontSize: 16, color: Themes.errorRed);

TextStyle get headline6 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500, fontSize: 14, color: Themes.cardFontColor2);

TextStyle get bodyText1 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w500, fontSize: 14, color: Themes.bottomNavFontColor);

TextStyle get bodyText2 => TextStyle(
    fontFamily: _font,
    fontWeight: FontWeight.w600, fontSize: 12, color: Themes.warning);
