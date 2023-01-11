

import '../models/result_model.dart';

class ResultFormStore {
  static String? victoryStatement;
  static List<List<ResultModel>>? resultFields = [
    [ResultModel()],[ResultModel()] // there must be atleast two positions
  ];

  static void addTeamAtPosition(int position) {
    resultFields?[position-1].add(ResultModel());
  }

  static void removeTeamAtPosition(int position, int team) {
    resultFields?[position-1].removeAt(team);
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

  static void clear()
  {
    resultFields = [
      [ResultModel()]
    ];
    victoryStatement = null;
  }
}
