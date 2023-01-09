import 'package:mobx/mobx.dart';

import '../globals/enums.dart';
part 'gc_store.g.dart';

class GCStore = _GCStore with _$GCStore;

abstract class _GCStore with Store {
  @observable
  Category selectedCategory = Category.men;

  @action
  void changeSelectedCategory(String c){
    Category.values.firstWhere((element){
      if(c==element.categoryName){
        selectedCategory=element;
        return true;
      }
      return false;
    });
  }

  @action
  void setFiltersToDefault(){

  }

}