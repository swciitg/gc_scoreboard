import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import '../globals/themes.dart';

class TopBar extends StatelessWidget {
  final selectedIndex;
  ValueChanged<int> onClicked;
  TopBar({super.key, this.selectedIndex, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Container(
        // height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            topBarItem(Icons.trending_up_outlined, 'Standings', 0),
            topBarItem(Icons.date_range_outlined, 'Schedule', 1),
            topBarItem(Icons.emoji_events_outlined, 'Results', 2),
          ],
        ),
      ),
    );
  }

  Widget topBarItem(IconData iconData, String label, int index) {
    return GestureDetector(
      onTap: () {
        onClicked(index);
      },
      child: ConstrainedBox(
        // width: width,
        constraints: BoxConstraints(
          minWidth: 104,
          maxWidth: 124,
        ),
        child: Container(
          // width: width * 0.8,
          height: 28,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: index == selectedIndex
                  ? Themes.primaryColor
                  : Themes.secondaryColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData,
                  color: index == selectedIndex
                      ? Themes.secondaryColor
                      : Themes.primaryColor,
                  size: 16),
              SizedBox(
                width: 8,
              ),
              Text(label,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: index == selectedIndex
                          ? Themes.secondaryColor
                          : Themes.primaryColor)),
            ],
          ),
        ),
      ),
    );
  }
}
