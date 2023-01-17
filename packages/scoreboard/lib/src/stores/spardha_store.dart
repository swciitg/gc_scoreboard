import 'package:mobx/mobx.dart';
import '../globals/enums.dart';
part 'spardha_store.g.dart';

class SpardhaStore = _SpardhaStore with _$SpardhaStore;

abstract class _SpardhaStore with Store {
  @observable
  Category selectedCategory = Category.men;

  @observable
  Hostel selectedHostel = Hostel.overall;

  @observable
  String selectedDate=''; // no date selected

  @observable
  String selectedEvent='Overall';

  @action
  void setFiltersToDefault(){
    selectedCategory=Category.men;
    selectedHostel=Hostel.overall;
    selectedDate='';
    selectedEvent='Overall';
  }

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
  void changeSelectedHostel(String h){
    Hostel.values.firstWhere((element){
      if(h==element.hostelName){
        selectedHostel=element;
        return true;
      }
      return false;
    });
  }

  @action
  void changeSelectedDate(String d){
    selectedDate=d;
  }

  @action
  void makeSelectedDateEmpty(){
    selectedDate='';
  }

  @action
  void changeSelectedEvent(String e){
    selectedEvent=e;

  }

}