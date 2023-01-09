import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../globals/enums.dart';
import 'kriti/kriti_home.dart';
import 'manthan/manthan_home.dart';
import 'spardha/results_page.dart';
import 'package:provider/provider.dart';
import 'spardha/schedule_page.dart';
import 'spardha/spardha_home.dart';
import 'spardha/standings_page.dart';

import '../stores/common_store.dart';

import 'gc_standings.dart';

class ScoreBoardHome extends StatefulWidget {
  static const id = '/gc/home';
  const ScoreBoardHome({Key? key}) : super(key: key);

  @override
  State<ScoreBoardHome> createState() => _ScoreBoardHomeState();
}

class _ScoreBoardHomeState extends State<ScoreBoardHome> {
  @override
  void initState() {
    super.initState();
  }

  Map<Pages, Widget> tabs = {
    Pages.schedule: const SchedulePage(),
    Pages.standings: const StandingsPage(),
    Pages.results: const ResultsPage(),
  };

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Observer(
      builder: (context) {
        return commonStore.competition == Competitions.gc
            ? const GCStandingsPage()
            : commonStore.competition == Competitions.spardha
            ? SpardhaHome() : (commonStore.competition == Competitions.kriti ? KritiHome() : ManthanHome());
      },
    );
  }
}
