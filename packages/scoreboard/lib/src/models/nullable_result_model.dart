import 'package:scoreboard/src/models/result_model.dart';

class NullableResultModel extends Comparable {
  int position;
  String? hostel;
  int? points;
  String? primaryScore;
  String? secondaryScore;
  NullableResultModel(
      {required this.position,
      this.hostel,
      this.points,
      this.primaryScore,
      this.secondaryScore});

  @override
  int compareTo(other) {
    return position.compareTo(other.position);
  }

  ResultModel toResultModel() {
    return ResultModel(
        position: position,
        hostel: hostel!,
        points: points!,
        primaryScore: primaryScore!,
        secondaryScore: secondaryScore);
  }

  NullableResultModel.fromResultModel(ResultModel r)
      : this(
            position: r.position,
            hostel: r.hostel,
            points: r.points,
            primaryScore: r.primaryScore,
            secondaryScore: r.secondaryScore);
}
