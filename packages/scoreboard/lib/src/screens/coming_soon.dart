import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scoreboard/src/widgets/common/top_bar.dart';

class ComingSoon extends StatefulWidget {
  final String competition;
  const ComingSoon({Key? key, required this.competition}) : super(key: key);

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    // print(widget.competition);
    return Column(
      children: [
        TopBar(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 140),
          child: SizedBox(
            height: 230,
            width: 220,
            child:
            widget.competition == 'Competitions.kriti'
                ? SvgPicture.asset(
              'assets/kriti_comingsoon.svg',
              package: 'scoreboard',
            )
                : widget.competition == 'Competitions.manthan'
                  ? SvgPicture.asset(
                  'assets/manthan_comingsoon.svg',
                  package: 'scoreboard',
            )
              : Container(),
            ),
          ),
      ],

    );
  }
}
