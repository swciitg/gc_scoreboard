import 'package:scoreboard/src/models/result_model.dart';

class ResultForm {
  static List<List<ResultModel>>? resultFields = [
    [ResultModel()]
  ];

  static void addTeamAtPosition(int index) {
    resultFields?[index].add(ResultModel());
    print(resultFields);
  }

  static void removeTeamAtPosition(int index, int team) {
    resultFields?[index].removeAt(team);
  }

  static int numPositions() {
    return resultFields!.length;
  }

  static void addNewPosition(int? value) {
    if (value == null) return;
    resultFields?.add([ResultModel()]);
  }

  static int numTeamsWithPosition(int position) {
    if (resultFields == null) return 0;
    return resultFields![position - 1].length;
  }
}
