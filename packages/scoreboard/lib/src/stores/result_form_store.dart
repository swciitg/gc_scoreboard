import 'package:scoreboard/src/models/result_model.dart';

class ResultForm {
  static List<ResultModel>? resultFields = [ResultModel(position: 1)] ;

  static void addTie(int position) {
    resultFields?.add(ResultModel(position: position));
    resultFields?.sort();
  }


  static void removePosition(int index) {
    resultFields?.removeAt(index);
    resultFields?.sort();
  }

  static int get numResults => resultFields?.length ?? 0;


  static void addNewPosition(int? value) {
    if (value == null) return;
    resultFields?.add(ResultModel(position: value + 1));
    resultFields?.sort();
  }

  static int numResultsWithPosition(int position) {
    if (resultFields == null) return 0;
    return resultFields!
        .where((element) => element.position == position)
        .length;
  }

  static bool displayAddTieIcon(int resultFieldIndex) =>
      numResultsWithPosition(resultFields![resultFieldIndex].position) < 2;

  static bool displayRemoveTieIcon(int resultFieldIndex) =>
      numResultsWithPosition(resultFields![resultFieldIndex].position) == 2 &&
      resultFieldIndex != 0 &&
      resultFields![resultFieldIndex].position ==
          resultFields![resultFieldIndex - 1].position;

  static bool displayAddPosition(int resultFieldIndex) =>
      resultFieldIndex == (numResults - 1);
}
