import '../../../models/manthan_models/manthan_result_model.dart';

class ManthanResultFormStore {
  static String? victoryStatement;
  static List<ManthanResultModel>? resultFields = [
    ManthanResultModel() // there must be atleast two positions
  ];

  static int numPositions() {
    return resultFields!.length;
  }

  static void addNewPosition(int? value) {
    if (value == null) return;
    resultFields?.add(ManthanResultModel());
  }

  static void clear() {
    resultFields = [ManthanResultModel()];
    victoryStatement = null;
  }
}
