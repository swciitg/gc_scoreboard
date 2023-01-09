import 'package:mobx/mobx.dart';
part 'manthan_store.g.dart';

class ManthanStore = _ManthanStore with _$ManthanStore;

abstract class _ManthanStore with Store {

  @action
  void setFiltersToDefault(){

  }

}