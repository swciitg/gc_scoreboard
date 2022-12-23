import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../globals/themes.dart';
import '../../stores/common_store.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return SafeArea(
      child: Container(
        color: Themes.bottomNavBarColor,
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Observer(
          builder: (context){
            return Row(
              children: [
                bottomNavigationBarItem(
                    'assets/gc.svg', 'GC', MediaQuery.of(context).size.width / 4, commonStore),
                bottomNavigationBarItem('assets/spardha2.svg', 'Spardha',
                    MediaQuery.of(context).size.width / 4, commonStore),
                bottomNavigationBarItem('assets/kriti2.svg', 'Kriti',
                    MediaQuery.of(context).size.width / 4, commonStore),
                bottomNavigationBarItem('assets/manthan2.svg', 'Manthan',
                    MediaQuery.of(context).size.width / 4, commonStore),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget bottomNavigationBarItem(
      String assetImageAddress, String label, double width, var store) {
    return GestureDetector(
      onTap: () {
        store.setCompetition(label);
      },
      child: SizedBox(
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
                    color: store.competition == label
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
                      fontWeight: store.competition == label
                          ? FontWeight.w600
                          : FontWeight.w500,
                      fontSize: 12,
                      color: store.competition == label
                          ? Themes.primaryColor
                          : Themes.bottomNavFontColor)),
            )
          ],
        ),
      ),
    );
  }
}
