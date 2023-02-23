import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../globals/enums.dart';
import 'kriti/kriti_home.dart';
import 'manthan/manthan_home.dart';
import 'spardha/spardha_home.dart';
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

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Observer(
      builder: (context) {
        return commonStore.competition == Competitions.gc
            ? const GCStandingsPage()
            : commonStore.competition == Competitions.spardha
                ? const SpardhaHome()
                : (commonStore.competition == Competitions.kriti
                    ? const KritiHome()
                    : const ManthanHome());
      },
    );
  }
}
