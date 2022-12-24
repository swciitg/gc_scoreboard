import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../globals/themes.dart';
import '../../stores/common_store.dart';

class TopBar extends StatefulWidget {
  TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Observer(
        builder: (context){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: topBarItem(Icons.trending_up_outlined, 'Standings', commonStore)),
              const SizedBox(width: 8,),
              Expanded(child: topBarItem(Icons.date_range_outlined, 'Schedule', commonStore)),
              const SizedBox(width: 8,),
              Expanded(child: topBarItem(Icons.emoji_events_outlined, 'Results', commonStore)),
            ],
          );
        },
      )
    );
  }

  Widget topBarItem(IconData iconData, String label, var store) {
    return GestureDetector(
      onTap: () {
        store.setPage(Pages.values.byName(label));
      },
      child: Container(
        // width: width * 0.8,
        // height: 28,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: store.page == Pages.values.byName(label)
                ? Themes.primaryColor
                : Themes.secondaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData,
                color: store.page == Pages.values.byName(label)
                    ? Themes.secondaryColor
                    : Themes.primaryColor,
                size: 16),
            const SizedBox(
              width: 8,
            ),
            Text(label,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: store.page == Pages.values.byName(label)
                        ? Themes.secondaryColor
                        : Themes.primaryColor)),
          ],
        ),
      ),
    );
  }
}
