import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../globals/themes.dart';

class BottomNavBar extends StatelessWidget {
  final selectedIndex;
  ValueChanged<int> onClicked;
  BottomNavBar({this.selectedIndex, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Themes.bottomNavBarColor,
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            bottomNavigationBarItem(
                'assets/gc.svg', 'GC', 0, MediaQuery.of(context).size.width / 4),
            bottomNavigationBarItem('assets/spardha2.svg', 'Spardha', 1,
                MediaQuery.of(context).size.width / 4),
            bottomNavigationBarItem('assets/kriti2.svg', 'Kriti', 2,
                MediaQuery.of(context).size.width / 4),
            bottomNavigationBarItem('assets/manthan2.svg', 'Manthan', 3,
                MediaQuery.of(context).size.width / 4),
          ],
        ),
      ),
    );
  }

  Widget bottomNavigationBarItem(
      String assetImageAddress, String label, int index, double width) {
    return GestureDetector(
      onTap: () {
        onClicked(index);
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12.5, 0, 4),
              child: Container(
                width: width * 0.8,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: index == selectedIndex
                        ? Themes.bottomNavHighlightColor
                        : Themes.bottomNavBarColor),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    assetImageAddress,
                    package: 'scoreboard',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(label,
                  style: GoogleFonts.montserrat(
                      fontWeight: index == selectedIndex
                          ? FontWeight.w600
                          : FontWeight.w500,
                      fontSize: 12,
                      color: index == selectedIndex
                          ? Themes.primaryColor
                          : Themes.bottomNavFontColor)),
            )
          ],
        ),
      ),
    );
  }
}
