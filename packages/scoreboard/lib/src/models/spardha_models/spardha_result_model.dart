import 'package:json_annotation/json_annotation.dart';
part 'spardha_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ResultModel {
  String? hostelName;
  String? primaryScore;
  String? secondaryScore;
  ResultModel({
    this.hostelName,
    this.primaryScore,
    this.secondaryScore,
  });
  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResultModelToJson(this);
}
