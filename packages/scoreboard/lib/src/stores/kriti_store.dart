import 'package:mobx/mobx.dart';
part 'kriti_store.g.dart';

class KritiStore = _KritiStore with _$KritiStore;

abstract class _KritiStore with Store {

  @action
  void setFiltersToDefault(){

  }

}