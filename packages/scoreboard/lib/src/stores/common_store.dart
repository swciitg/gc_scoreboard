// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';
import '../globals/enums.dart';
part 'common_store.g.dart';

class CommonStore = _CommonStore with _$CommonStore;

abstract class _CommonStore with Store {
  @observable
  Competitions competition = Competitions.gc;

  @observable
  Pages page = Pages.standings;

  @observable
  ViewType viewType = ViewType.user;

  @observable
  Category selectedCategory = Category.overall;

  @observable
  Hostel selectedHostel = Hostel.overall;

  @observable
  String selectedDate=''; // no date selected

  @observable
  String selectedEvent='Overall';

  @observable
  bool fetchedData = false;

  @action
  void setCompetition(Competitions c) {
    print(c);
    competition = c;
    // chaning filters to default
    selectedCategory=Category.overall;
    selectedHostel=Hostel.overall;
    selectedDate='';
    selectedEvent='Overall';
  }

  @action
  void setPage(Pages p) {
    page = p;
    // chaning filters to default
    selectedCategory=Category.overall;
    selectedHostel=Hostel.overall;
    selectedDate='';
    selectedEvent='Overall';
  }

  @action
  void setViewType(ViewType v){
    print(v);
    viewType=v;
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
    print(selectedEvent);
  }

  @action
  void changeFetchedData(){
    fetchedData=!fetchedData;
  }

}
