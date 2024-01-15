import 'package:json_annotation/json_annotation.dart';
part 'sahyog_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SahyogResultModel {
  String? hostelName;
  double? points;
  SahyogResultModel({
    this.hostelName,
    this.points,
  });
  factory SahyogResultModel.fromJson(Map<String, dynamic> json) =>
      _$SahyogResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$SahyogResultModelToJson(this);
}
