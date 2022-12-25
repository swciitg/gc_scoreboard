import 'package:flutter/material.dart';
import 'package:scoreboard/src/widgets/common/top_bar.dart';
import '../widgets/common/filter_bar.dart';
import '../widgets/scoreboard/standingboard.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({super.key});

  @override
  State<StandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  final TextEditingController sport = TextEditingController(text: "Overall");
  final TextEditingController hostel = TextEditingController(text: "Overall");
  final TextEditingController category = TextEditingController(text: "Overall");

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            const TopBar(),
            FilterBar(sport: sport, hostel: hostel, category: category, screen: 'standings',),
            const Expanded(child: StandingBoard())
          ],
        ),
      );
  }
}
