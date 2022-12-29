import 'package:json_annotation/json_annotation.dart';

part 'result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ResultModel {
  int position;
  String hostel;
  int points;
  String primaryScore;
  String? secondaryScore;
  ResultModel({
    required this.position,
    required this.hostel,
    required this.points,
    required this.primaryScore,
    this.secondaryScore,
  });

  factory ResultModel.fromJson(Map<String,dynamic> json) => _$ResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResultModelToJson(this);

}
