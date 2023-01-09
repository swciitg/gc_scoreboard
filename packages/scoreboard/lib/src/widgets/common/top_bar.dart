import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../stores/common_store.dart';
import '../../stores/gc_store.dart';
import '../../stores/kriti_store.dart';
import '../../stores/manthan_store.dart';
import '../../stores/spardha_store.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(
            child: TopBarItem(
              page: Pages.standings,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: TopBarItem(
              page: Pages.schedule,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: TopBarItem(
              page: Pages.results,
            ),
          ),
        ],
      ),
    );
  }
}

class TopBarItem extends StatelessWidget {
  final Pages page;
  const TopBarItem({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommonStore commonStore = context.read<CommonStore>();

    var competitionStore;
    switch(commonStore.competition){
      case Competitions.gc : {
        competitionStore = context.read<GCStore>();
      } break;
      case Competitions.spardha : {
        competitionStore = context.read<SpardhaStore>();
      } break;
      case Competitions.kriti : {
        competitionStore = context.read<KritiStore>();
      } break;
      case Competitions.manthan : {
        competitionStore = context.read<ManthanStore>();
      } break;
    }

    return GestureDetector(
      onTap: () {
        commonStore.setPage(page,competitionStore);
      },
      child: Observer(builder: (context) {
        return Container(
          // width: width * 0.8,
          // height: 28,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: commonStore.page == page
                  ? Themes.primaryColor
                  : Themes.secondaryColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(page.icon,
                  color: commonStore.page == page
                      ? Themes.secondaryColor
                      : Themes.primaryColor,
                  size: 16),
              const SizedBox(
                width: 8,
              ),
              Text(page.name,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: commonStore.page == page
                          ? Themes.secondaryColor
                          : Themes.primaryColor)),
            ],
          ),
        );
      }),
    );
  }
}
