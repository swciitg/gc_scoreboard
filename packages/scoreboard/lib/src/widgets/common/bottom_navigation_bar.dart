import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../stores/common_store.dart';
import '../../stores/gc_store.dart';
import '../../stores/kriti_store.dart';
import '../../stores/manthan_store.dart';
import '../../stores/spardha_store.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return Container(
        color: Themes.bottomNavBarColor,
        height: 90,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            BottomNavBarItem(
                competition: Competitions.gc, width: mediaWidth / 4),
            BottomNavBarItem(
                competition: Competitions.spardha, width: mediaWidth / 4),
            BottomNavBarItem(
                competition: Competitions.kriti, width: mediaWidth / 4),
            BottomNavBarItem(
                competition: Competitions.manthan, width: mediaWidth / 4),
          ],
        ));
  }
}

class BottomNavBarItem extends StatelessWidget {
  final double width;
  final Competitions competition;

  const BottomNavBarItem({
    Key? key,
    required this.width,
    required this.competition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommonStore commonStore = context.read<CommonStore>();

    var competitionStore;
    switch (competition) {
      case Competitions.gc:
        {
          competitionStore = context.read<GCStore>();
        }
        break;
      case Competitions.spardha:
        {
          competitionStore = context.read<SpardhaStore>();
        }
        break;
      case Competitions.kriti:
        {
          competitionStore = context.read<KritiStore>();
        }
        break;
      case Competitions.manthan:
        {
          competitionStore = context.read<ManthanStore>();
        }
        break;
    }

    return Observer(builder: (context) {
      return GestureDetector(
        onTap: () {
          commonStore.setCompetition(competition, competitionStore);
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
                      color: commonStore.competition == competition
                          ? Themes.bottomNavHighlightColor
                          : Themes.bottomNavBarColor),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      competition.assetPath,
                      package: 'scoreboard',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(competition.name,
                    style: GoogleFonts.montserrat(
                        fontWeight: commonStore.competition == competition
                            ? FontWeight.w600
                            : FontWeight.w500,
                        fontSize: 12,
                        color: commonStore.competition == competition
                            ? Themes.primaryColor
                            : Themes.bottomNavFontColor)),
              )
            ],
          ),
        ),
      );
    });
  }
}
