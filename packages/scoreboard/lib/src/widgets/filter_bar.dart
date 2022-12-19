import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../globals/themes.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Container(
        height: 56,
        child: Row(
          children: [
            Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Themes.cardColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 12,
                                child: Text('Sport',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Themes.cardFontColor1)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 18,
                                child: Text('Overall',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Themes.cardFontColor2)),
                              )
                            ],
                          ),
                          Icon(
                            Icons.unfold_more_outlined,
                            size: 20,
                            color: Themes.cardFontColor1,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Themes.cardColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 12,
                                child: Text('Hostel',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Themes.cardFontColor1)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 18,
                                child: Text('Overall',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Themes.cardFontColor2)),
                              )
                            ],
                          ),
                          Icon(
                            Icons.unfold_more_outlined,
                            size: 20,
                            color: Themes.cardFontColor1,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: Container(
                      alignment: Alignment.center,
                      height: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Themes.cardColor),
                      child: Icon(
                        Icons.event_outlined,
                        size: 24,
                        color: Themes.primaryColor,
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
