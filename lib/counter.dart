import 'package:mobx/mobx.dart';

part 'counter.g.dart';

class CounterStore = Counter with _$CounterStore;

abstract class Counter with Store {
  @observable
  List<int> l = [1];

  @observable
  int counter = 1;

  @action
  void addSame(int value) {
    l.add(value);
    l.sort();
    
  }

 
}
