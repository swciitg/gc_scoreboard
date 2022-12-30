import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

final boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(18),
    color: Themes.cardColor1
);

const popUpIcon = Icon(
  Icons.unfold_more_outlined,
  size: 20,
  color: Themes.cardFontColor1,
);

final popUpHeadingStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    fontSize: 10,
    color: Themes.cardFontColor1
);

final popUpItemStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: Themes.cardFontColor2
);