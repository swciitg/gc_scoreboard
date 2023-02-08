import '../../../models/kriti_models/kriti_result_model.dart';

class KritiResultFormStore {
  static String? victoryStatement;
  static List<KritiResultModel>? resultFields = [
    KritiResultModel() // there must be atleast two positions
  ];

  static int numPositions() {
    return resultFields!.length;
  }

  static void addNewPosition(int? value) {
    if (value == null) return;
    resultFields?.add(KritiResultModel());
  }

  static void clear() {
    resultFields = [KritiResultModel()];
    victoryStatement = null;
  }
}
