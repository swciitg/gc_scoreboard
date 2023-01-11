import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoreboard/src/globals/colors.dart';
import 'package:scoreboard/src/globals/enums.dart';

class ComingSoon extends StatefulWidget {
  final Competitions competition;
  const ComingSoon({Key? key, required this.competition}) : super(key: key);

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    // print(widget.competition);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("packages/scoreboard/assets/restricted_access.svg"),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              "Coming soon!",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  color: Themes.kWhite,
                  fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "${widget.competition.name} hasn't begun yet. We'll update this page as soon as ${widget.competition.name} starts",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  color: Themes.bottomNavFontColor,
                  fontSize: 12),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
