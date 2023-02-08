import 'package:mobx/mobx.dart';
import 'package:scoreboard/src/globals/enums.dart';
part 'sahyog_store.g.dart';

class SahyogStore = _SahyogStore with _$SahyogStore;

abstract class _SahyogStore with Store {

  @observable
  Club selectedClub = Club.overall;

  @observable
  String selectedEvent = 'Overall';

  @action
  void setFiltersToDefault() {
    selectedClub = Club.overall;
    selectedEvent = 'Overall';
  }

  @action
  void changeSelectedEvent(String e) {
    selectedEvent = e;
  }


  @action
  void changeSelectedClub(String c) {
    Club.values.firstWhere((element) {
      if (c == element.clubName) {
        selectedClub = element;
        return true;
      }
      return false;
    });
  }
}
