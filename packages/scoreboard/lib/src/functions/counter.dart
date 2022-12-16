import 'package:mobx/mobx.dart';

part 'counter.g.dart';

class CounterStore = Counter with _$CounterStore;

abstract class Counter with Store {
  @observable
  ObservableList<int> l = ObservableList<int>.of([1]);

  @observable
  int counter = 1;

  @action
  void addSame(int value) {
    l.add(value);
    l.sort();
  }

  @action
  void removeSame(int index) {
    l.removeAt(index);
    l.sort();
  }

  @action
  void addDifferent(int value) {
    l.add(value+1);
    l.sort();
  }
}
