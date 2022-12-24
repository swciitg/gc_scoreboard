// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'common_store.g.dart';

enum Competitions {
  spardha("Spardha","assets/spardha2.svg"),
  kriti("Kriti","assets/kriti2.svg"),
  manthan("Manthan","assets/manthan2.svg"),
  gc("GC","assets/gc.svg");

  final String name;
  final String assetPath;
  const Competitions(this.name,this.assetPath);

}

enum Pages {
  standings("Standings", Icons.trending_up_outlined),
  schedule("Schedule", Icons.date_range_outlined),
  results("Results", Icons.emoji_events_outlined);

  final String name;
  final IconData icon;
  const Pages(this.name,this.icon);
}

class CommonStore = _CommonStore with _$CommonStore;

abstract class _CommonStore with Store {
  @observable
  Competitions competition = Competitions.spardha;

  @observable
  Pages page = Pages.standings;

  @action
  void setCompetition(Competitions c) {
    competition = c;
  }

  @action
  void setPage(Pages p) {
    page = p;
  }
}
