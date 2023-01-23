import 'package:mobx/mobx.dart';
import 'package:scoreboard/src/globals/enums.dart';
part 'kriti_store.g.dart';

class KritiStore = _KritiStore with _$KritiStore;

abstract class _KritiStore with Store {
  @observable
  Cup selectedCup = Cup.overall;

  @observable
  Club selectedClub = Club.overall;

  @observable
  String selectedEvent = 'Overall';

  @action
  void setFiltersToDefault() {
    selectedClub = Club.overall;
    selectedCup = Cup.overall;
    selectedEvent = 'Overall';
  }

  @action
  void changeSelectedEvent(String e) {
    selectedEvent = e;
  }


  @action
  void changeSelectedCup(String c) {
    Cup.values.firstWhere((element) {
      if (c == element.cupName) {
        selectedCup = element;
        return true;
      }
      return false;
    });
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
