import 'package:mobx/mobx.dart';
import 'package:scoreboard/src/globals/enums.dart';
part 'sahyog_store.g.dart';

class SahyogStore = _SahyogStore with _$SahyogStore;

abstract class _SahyogStore with Store {

  @observable
  SahyogClub selectedClub = SahyogClub.overall;

  @observable
  String selectedEvent = 'Overall';

  @observable
  String difficulty = "Overall";

  @action
  void setFiltersToDefault() {
    selectedClub = SahyogClub.overall;
    selectedEvent = 'Overall';
    difficulty = "Overall";
  }

  @action
  void changeSelectedEvent(String e) {
    selectedEvent = e;
  }

  @action
  void changeDifficulty(String e)
  {
    difficulty = e;
  }


  @action
  void changeSelectedClub(String c) {
    SahyogClub.values.firstWhere((element) {
      if (c == element.clubName) {
        selectedClub = element;
        return true;
      }
      return false;
    });
  }
}
