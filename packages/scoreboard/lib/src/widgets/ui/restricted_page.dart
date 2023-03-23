import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../globals/styles.dart';

class RestrictedPage extends StatefulWidget {
  const RestrictedPage({Key? key}) : super(key: key);

  @override
  State<RestrictedPage> createState() => _RestrictedPageState();
}

class _RestrictedPageState extends State<RestrictedPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("packages/scoreboard/assets/restricted_access.svg"),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              "Restricted access!",
              style: fontStyle2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "You don't have admin access for this competition. Switch to audience view to see this section as an audience",
              style: bottomNavStyle1,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
