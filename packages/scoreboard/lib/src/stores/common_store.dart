// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';
import '../globals/enums.dart';
part 'common_store.g.dart';

class CommonStore = _CommonStore with _$CommonStore;

abstract class _CommonStore with Store {

  // static List<String> spardhaEvents=[];

  @observable
  Competitions competition = Competitions.gc;

  @observable
  Pages page = Pages.standings;

  @observable
  bool isAdmin=false; // if any competition admin

  @observable
  ViewType viewType = ViewType.user;

  @observable
  bool isSpardhaAdmin=false;

  @observable
  bool isKritiAdmin=false;

  @observable
  bool isManthanAdmin=false;

  @action
  void setViewType(ViewType v){
    viewType=v;
  }

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
  void setAdminNone(){
    isAdmin=false;
    isSpardhaAdmin=false;
    isKritiAdmin=false;
    isManthanAdmin=false;
  }

  @action
  void setSpardhaAdmin(bool input){
    isSpardhaAdmin=input;
    isAdmin=true;
  }

  @action
  void setKritiAdmin(bool input){
    isKritiAdmin=input;
    isAdmin=true;
  }

  @action
  void setManthanAdmin(bool input){
    isManthanAdmin=input;
    isAdmin=true;
  }

}
