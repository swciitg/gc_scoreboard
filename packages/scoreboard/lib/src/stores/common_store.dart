// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'common_store.g.dart';

enum Competitions {
  spardha("Spardha","assets/spardha2.svg"),
  kriti("Kriti","assets/kriti2.svg"),
  manthan("Manthan","assets/manthan2.svg"),
  gc("GC","assets/gc.svg");

  final String name;
  final String assetPath;
  const Competitions(this.name,this.assetPath);

}

enum ViewType {
  user, admin
}

enum Pages {
  standings("Standings", Icons.trending_up_outlined),
  schedule("Schedule", Icons.date_range_outlined),
  results("Results", Icons.emoji_events_outlined);

  final String name;
  final IconData icon;
  const Pages(this.name,this.icon);
}

enum Category {
  overall("Overall"),
  men("Men"),
  women("Women"),
  menandwomen("Men + Women");

  final String categoryName;
  const Category(this.categoryName);
}

enum Hostel {
  overall("Overall"),
  brahmaputra("Brahmaputra"),
  kameng("Kameng");

  final String hostelName;
  const Hostel(this.hostelName);
}

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

}
