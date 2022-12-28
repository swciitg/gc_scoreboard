import 'package:scoreboard/src/models/result_model.dart';

class NullableResultModel{
  String? hostel;
  int? points;
  String? primaryScore;
  String? secondaryScore;
  NullableResultModel(
      {
      this.hostel,
      this.points,
      this.primaryScore,
      this.secondaryScore});



  ResultModel toResultModel() {
    return ResultModel(
        hostel: hostel!,
        points: points!,
        primaryScore: primaryScore!,
        secondaryScore: secondaryScore);
  }

  NullableResultModel.fromResultModel(ResultModel r)
      : this(
            hostel: r.hostel,
            points: r.points,
            primaryScore: r.primaryScore,
            secondaryScore: r.secondaryScore);
}
