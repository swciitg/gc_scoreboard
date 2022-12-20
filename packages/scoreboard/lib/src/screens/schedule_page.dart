import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoreboard/src/globals/helper_variables.dart';
import 'package:scoreboard/src/widgets/filter_bar.dart';
import 'package:scoreboard/src/widgets/top_bar.dart';

import '../globals/themes.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_navigation_bar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int _selectedNavBarItemIndex = 1;
  int _selectedTopBarItemIndex = 1;

  void onTapped(int index) {
    setState(() {
      _selectedTopBarItemIndex = index;
    });
  }

  void onClicked(int index) {
    setState(() {
      _selectedNavBarItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: appBar(context,viewType.user),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            TopBar(
              onClicked: onTapped,
              selectedIndex: _selectedTopBarItemIndex,
            ),
            FilterBar(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedNavBarItemIndex,
        onClicked: onClicked,
      ),
    );
  }
}
