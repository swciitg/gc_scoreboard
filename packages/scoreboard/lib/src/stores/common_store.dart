// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
part 'common_store.g.dart';


enum Competitions {Spardha, Kriti, Manthan, GC}
enum Pages {Standings, Schedule, Results}

class CommonStore = _CommonStore with _$CommonStore;

abstract class _CommonStore with Store {
  @observable
  Competitions competition = Competitions.Spardha;

  @observable
  Pages page = Pages.Standings;

  @action
  void setCompetition(Competitions c) {
    competition = c;
  }

  @action
  void setPage(Pages p) {
    page = p;
  }

}
