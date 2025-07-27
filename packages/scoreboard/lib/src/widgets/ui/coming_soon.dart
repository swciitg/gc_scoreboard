import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../globals/enums.dart';
import '../../globals/styles.dart';

class ComingSoon extends StatefulWidget {
  final Competitions competition;
  const ComingSoon({super.key, required this.competition});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("packages/scoreboard/assets/coming_soon.svg"),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              "Coming soon!",
              style: fontStyle2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "${widget.competition.name} hasn't begun yet. We'll update this page as soon as ${widget.competition.name} starts",
              style: bottomNavStyle1,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
