import 'package:json_annotation/json_annotation.dart';
part 'kriti_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class KritiResultModel {
  String? hostelName;
  double? points;
  KritiResultModel({
    this.hostelName,
    this.points
  });
  factory KritiResultModel.fromJson(Map<String, dynamic> json) =>
      _$KritiResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$KritiResultModelToJson(this);
}