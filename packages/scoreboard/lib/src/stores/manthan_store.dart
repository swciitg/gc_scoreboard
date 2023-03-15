import 'package:mobx/mobx.dart';
part 'manthan_store.g.dart';

class ManthanStore = _ManthanStore with _$ManthanStore;

abstract class _ManthanStore with Store {

  @observable
  String selectedModule = 'Overall';

  @observable
  String selectedEvent = 'Overall';

  @action
  void setFiltersToDefault() {
    selectedModule = 'Overall';
    selectedEvent = 'Overall';
  }

  @action
  void changeSelectedEvent(String e) {
    selectedEvent = e;
  }


  @action
  void changeSelectedModule(String c) {
    selectedModule = c;
  }

}