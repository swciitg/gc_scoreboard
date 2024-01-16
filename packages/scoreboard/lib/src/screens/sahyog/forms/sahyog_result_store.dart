import '../../../models/sahyog_models/sahyog_result_model.dart';

class SahyogResultFormStore {
  static String? victoryStatement;
  static List<SahyogResultModel>? resultFields = [
    SahyogResultModel() // there must be atleast two positions
  ];
  static String? link;

  static int numPositions() {
    return resultFields!.length;
  }

  static void addNewPosition(int? value) {
    if (value == null) return;
    resultFields?.add(SahyogResultModel());
  }

  static void updateResultLink(String? value) {
    link = value;
  }

  static void clear() {
    resultFields = [SahyogResultModel()];
    victoryStatement = null;
    link = null;
  }
}
