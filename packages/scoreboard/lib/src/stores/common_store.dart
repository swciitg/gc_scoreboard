// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';
import 'package:scoreboard/src/stores/static_store.dart';
import '../globals/enums.dart';
part 'common_store.g.dart';

class CommonStore = _CommonStore with _$CommonStore;

abstract class _CommonStore with Store {

  static List<String> spardhaEvents=[];

  @observable
  Competitions competition = Competitions.gc;

  @observable
  Pages page = Pages.standings;

  @observable
  ViewType viewType = ViewType.user;

  @observable
  bool isSpardhaAdmin=false;

  @observable
  bool isKritiAdmin=false;

  @observable
  bool isManthanAdmin=false;

  @action
  void setCompetition(Competitions c,var competitionStore) {
    print(c);
    competition = c;
    // changing filters to default
    competitionStore.setFiltersToDefault();
  }

  @action
  void setPage(Pages p,var competitionStore) {
    page = p;
    // changing filters to default
    competitionStore.setFiltersToDefault();
  }

  @action
  void setViewType(ViewType v){
    print(v);
    viewType=v;
  }

  @action
  void setAdminNone(){
    isSpardhaAdmin=false;
    isKritiAdmin=false;
    isManthanAdmin=false;
  }

  @action
  void setSpardhaAdmin(bool input){
    isSpardhaAdmin=input;
  }

  @action
  void setKritiAdmin(bool input){
    isKritiAdmin=input;
  }

  @action
  void setManthanAdmin(bool input){
    isManthanAdmin=input;
  }

}
