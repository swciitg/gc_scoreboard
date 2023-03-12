import 'package:json_annotation/json_annotation.dart';
part 'manthan_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ManthanResultModel {
  String? hostelName;
  double? primaryScore;
  String? secondaryScore;
  ManthanResultModel({
    this.hostelName,
    this.primaryScore,
    this.secondaryScore,
  });
  factory ManthanResultModel.fromJson(Map<String, dynamic> json) =>
      _$ManthanResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ManthanResultModelToJson(this);
}
