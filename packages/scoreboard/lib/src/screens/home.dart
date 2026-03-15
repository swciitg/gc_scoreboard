import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../globals/enums.dart';
import 'kriti/kriti_home.dart';
import 'manthan/manthan_home.dart';
import 'sahyog/sahyog_home.dart';
import 'spardha/spardha_home.dart';
import '../stores/common_store.dart';
import 'gc_standings.dart';

class ScoreBoardHome extends StatefulWidget {
  static const id = '/gc/home';
  const ScoreBoardHome({super.key});

  @override
  State<ScoreBoardHome> createState() => _ScoreBoardHomeState();
}

class _ScoreBoardHomeState extends State<ScoreBoardHome> {
  @override
  void initState() {
    super.initState();
  }

  Widget _getCompetitionPage(CommonStore commonStore) {
      switch (commonStore.competition) {
      case Competitions.gc:
        return const GCStandingsPage();
      case Competitions.spardha:
        return const SpardhaHome();
      case Competitions.kriti:
        return const KritiHome();
      case Competitions.manthan:
        return const ManthanHome();
      case Competitions.sahyog:
        return const SahyogHome();
      }
    }

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();

    return Observer(
      builder: (_) => _getCompetitionPage(commonStore),
    );
  }
}
