import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../globals/themes.dart';

PreferredSize appBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(56),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      child: Container(
        // color: Colors.orange,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 0,
                ),
                child: Container(
                  // width: width * 0.8,
                  width: 80,

                  height: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Themes.cardColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_outlined,
                        size: 16,
                        color: Themes.primaryColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('One',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Themes.primaryColor)),
                      Text('.',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Themes.dotColor)),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Text('Scoreboard',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Themes.primaryColor)),
                  Text('.',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: Themes.dotColor)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  // width: width * 0.8,
                  width: 80,

                  height: 36,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
