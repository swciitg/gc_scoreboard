import 'package:mobx/mobx.dart';
import 'package:scoreboard/src/models/event_model.dart';
import 'package:scoreboard/src/models/nullable_result_model.dart';

part 'counter.g.dart';

class CounterStore = Counter with _$CounterStore;

abstract class Counter with Store {
  final EventModel event;
  Counter({required this.event}) {
    if (event.results.isEmpty) {
      resultFields = ObservableList<NullableResultModel>.of([NullableResultModel(position: 1)]);
    }
  }

  @observable
  ObservableList<int> l = ObservableList<int>.of([1]);

  @observable
  late ObservableList<NullableResultModel> resultFields;

  @action
  void addSame(int value) {
    l.add(value);
    l.sort();
  }

  @action
  void addTie(int position) {
    resultFields.add(NullableResultModel(position: position));
    resultFields.sort();
  }

  @action
  void removeSame(int index) {
    l.removeAt(index);
    l.sort();
  }


  @action
  void removePosition(int index) {
    resultFields.removeAt(index);
    resultFields.sort();
  }

  @action
  void addDifferent(int value) {
    l.add(value + 1);
    l.sort();
  }

  @action
  void addNewPosition(int value) {
    resultFields.add(NullableResultModel(position: value + 1));
    resultFields.sort();
  }
}


