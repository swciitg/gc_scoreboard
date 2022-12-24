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
    return SafeArea(
      child: Container(
        color: Themes.bottomNavBarColor,
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            BottomNavBarItem(
                assetImageAddress: 'assets/gc.svg',
                label: 'GC',
                width: MediaQuery.of(context).size.width / 4),
            BottomNavBarItem(
                assetImageAddress: 'assets/spardha2.svg',
                label: 'Spardha',
                width: MediaQuery.of(context).size.width / 4),
            BottomNavBarItem(
                assetImageAddress: 'assets/kriti2.svg',
                label: 'Kriti',
                width: MediaQuery.of(context).size.width / 4),
            BottomNavBarItem(
                assetImageAddress: 'assets/manthan2.svg',
                label: 'Manthan',
                width: MediaQuery.of(context).size.width / 4),
          ],
        )
      ),
    );
  }
}

class BottomNavBarItem extends StatelessWidget {
  final double width;
  final String label;
  final String assetImageAddress;

  const BottomNavBarItem({
    Key? key,
    required this.width,
    required this.label,
    required this.assetImageAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommonStore store = context.read<CommonStore>();
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            store.setCompetition(Competitions.values.byName(label));
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
                        color:
                            store.competition == Competitions.values.byName(label)
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
                          fontWeight:
                              store.competition == Competitions.values.byName(label)
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                          fontSize: 12,
                          color:
                              store.competition == Competitions.values.byName(label)
                                  ? Themes.primaryColor
                                  : Themes.bottomNavFontColor)),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
