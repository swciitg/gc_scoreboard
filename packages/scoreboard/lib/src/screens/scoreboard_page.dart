import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoreboard/src/widgets/top_bar.dart';

import '../globals/themes.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/scoreboard/filter_board.dart';
import '../widgets/scoreboard/standingboard.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({super.key});

  @override
  State<StandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  int _selectedNavBarItemIndex = 1;
  int _selectedTopBarItemIndex = 1;
  final _itemsCategory = ['Overall','Men', 'Women'];
  final _itemsSports = ['Overall', 'hockey', 'football'];
  String _category = 'Overall';
  String _sports = 'Overall';

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

  void onFilteringCategory(String index) {
    setState(() {
      _category = index;
    });
  }

  void onFilteringSports(String index) {
    setState(() {
      _sports = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          // color: Colors.orange,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 80,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Themes.cardColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.arrow_back_outlined,
                            size: 16,
                            color: Themes.primaryColor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text('One',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Themes.primaryColor)),
                          Text('.',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Themes.dotColor)),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text('Scoreboard',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: Themes.primaryColor)),
                      Text('.',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: Themes.dotColor)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      // width: width * 0.8,
                      width: 80,
                      height: 36,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            TopBar(
              onClicked: onTapped,
              selectedIndex: _selectedTopBarItemIndex,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
              child: SizedBox(
                height: 56,
                child: Row(
                  children: [
                    FilterList(
                        heading: 'Category',
                        items: _itemsCategory,
                        callbackFunction: onFilteringCategory,
                        index: _category),
                    FilterList(
                        heading: 'Sports',
                        items: _itemsSports,
                        callbackFunction: onFilteringSports,
                        index: _sports),
                  ],
                ),
              ),
            ),
            StandingBoard()
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
