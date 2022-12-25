import 'package:flutter/material.dart';
import 'package:scoreboard/src/widgets/common/top_bar.dart';
import 'package:scoreboard/src/widgets/scoreboard/filter_standings.dart';
import '../widgets/scoreboard/standingboard.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({super.key});

  @override
  State<StandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  final TextEditingController sport = TextEditingController(text: "Overall");
  final TextEditingController category = TextEditingController(text: "Overall");
  final List<String> _itemsSports = [
    'Overall',
    'Athletics',
    'Swimming',
    'Basketball',
    'Football',
    'Badminton',
    'Aquatics'
  ];
  final _itemsCategory = ['Overall', 'Men', 'Women'];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            TopBar(),
            FilterStandings(category: category, sport: sport, itemsSports: _itemsSports, itemsCategory: _itemsCategory),
            const Expanded(child: StandingBoard())
          ],
        ),
      );
  }
}
