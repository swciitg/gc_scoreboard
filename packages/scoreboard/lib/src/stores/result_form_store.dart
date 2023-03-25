

import '../models/spardha_models/spardha_result_model.dart';

class ResultFormStore {
  static String? victoryStatement;
  static List<List<SpardhaResultModel>>? resultFields = [
    [SpardhaResultModel()],[SpardhaResultModel()] // there must be atleast two positions
  ];

  static void addTeamAtPosition(int position) {
    resultFields?[position-1].add(SpardhaResultModel());
  }

  static void removeTeamAtPosition(int position, int team) {
    resultFields?[position-1].removeAt(team);
  }

  static int numPositions() {
    return resultFields!.length;
  }

  static void addNewPosition(int? value) {
    if (value == null) return;
    resultFields?.add([SpardhaResultModel()]);
  }

  static int numTeamsWithPosition(int position) {
    if (resultFields == null) return 0;
    return resultFields![position - 1].length;
  }

  static void clear()
  {
    resultFields = [
      [SpardhaResultModel()]
    ];
    victoryStatement = null;
  }
}
