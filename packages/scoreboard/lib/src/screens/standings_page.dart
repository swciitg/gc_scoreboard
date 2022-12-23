import 'package:flutter/material.dart';
import 'package:scoreboard/src/widgets/common/top_bar.dart';
import '../widgets/scoreboard/filter_board.dart';
import '../widgets/scoreboard/standingboard.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({super.key});

  @override
  State<StandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  final _itemsCategory = ['Overall', 'Men', 'Women'];
  final _itemsSports = ['Overall', 'hockey', 'football'];
  String _category = 'Overall';
  String _sports = 'Overall';


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
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            TopBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
              child: SizedBox(
                height: 75,
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
            const Expanded(child: StandingBoard())
          ],
        ),
      );
  }
}
