import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../globals/themes.dart';

PopupMenuEntry OptionsMenuItem(String label, String value, Color color) {
  return PopupMenuItem(
      value: value,
      child: Text(label,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500, fontSize: 12, color: color)));
}
