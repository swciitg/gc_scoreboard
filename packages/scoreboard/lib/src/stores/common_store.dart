// ignore_for_file: library_private_types_in_public_api

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
  standings("Standings"),
  schedule("Schedule"),
  results("Results");

  final String name;
  const Pages(this.name);
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
