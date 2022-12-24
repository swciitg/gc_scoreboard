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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(
            child: TopBarItem(
              iconData: Icons.trending_up_outlined,
              label: 'Standings',
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: TopBarItem(
              iconData: Icons.date_range_outlined,
              label: 'Schedule',
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: TopBarItem(
              iconData: Icons.emoji_events_outlined,
              label: 'Results',
            ),
          ),
        ],
      ),
    );
  }
}

class TopBarItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  const TopBarItem({
    Key? key,
    required this.iconData,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommonStore store = context.read<CommonStore>();
    return GestureDetector(
      onTap: () {
        store.setPage(Pages.values.byName(label));
      },
      child: Observer(builder: (context) {
        return Container(
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
        );
      }),
    );
  }
}
