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

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            const TopBar(),
            FilterBar(),
            const Expanded(child: StandingBoard())
          ],
        ),
      );
  }
}
