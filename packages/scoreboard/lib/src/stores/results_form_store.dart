import 'package:mobx/mobx.dart';
import 'package:scoreboard/src/models/event_model.dart';
import 'package:scoreboard/src/models/nullable_result_model.dart';

part 'results_form_store.g.dart';

class ResultsFormStore = ResultsFormStoreBase with _$ResultsFormStore;

abstract class ResultsFormStoreBase with Store {
  final EventModel event;
  ResultsFormStoreBase({required this.event}) {
    if (event.winners.isEmpty) {
      resultFields = ObservableList<NullableResultModel>.of(
          [NullableResultModel(position: 1)]);
    } else {
      resultFields = ObservableList<NullableResultModel>.of(
        event.winners.map((e) => NullableResultModel.fromResultModel(e)).toList()
      );
    }
  }

  @observable
  ObservableList<NullableResultModel>? resultFields;

  @action
  void addTie(int position) {
    resultFields?.add(NullableResultModel(position: position));
    resultFields?.sort();
  }

  @action
  void removePosition(int index) {
    resultFields?.removeAt(index);
    resultFields?.sort();
  }

  int get numResults => resultFields?.length ?? 0;

  @action
  void addNewPosition(int? value) {
    if (value == null) return;
    resultFields?.add(NullableResultModel(position: value + 1));
    resultFields?.sort();
  }

  int numResultsWithPosition(int position) {
    if (resultFields == null) return 0;
    return resultFields!
        .where((element) => element.position == position)
        .length;
  }

  bool displayAddTieIcon(int resultFieldIndex) =>
      numResultsWithPosition(resultFields![resultFieldIndex].position) < 2;

  bool displayRemoveTieIcon(int resultFieldIndex) =>
      numResultsWithPosition(resultFields![resultFieldIndex].position) == 2 &&
      resultFieldIndex != 0 &&
      resultFields![resultFieldIndex].position ==
          resultFields![resultFieldIndex - 1].position;

  bool displayAddPosition(int resultFieldIndex) =>
      resultFieldIndex == (numResults - 1) ;
}
