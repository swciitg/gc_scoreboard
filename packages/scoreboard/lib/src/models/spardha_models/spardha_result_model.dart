import 'package:json_annotation/json_annotation.dart';
part 'spardha_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SpardhaResultModel {
  String? hostelName;
  String? primaryScore;
  String? secondaryScore;
  SpardhaResultModel({
    this.hostelName,
    this.primaryScore,
    this.secondaryScore,
  });
  factory SpardhaResultModel.fromJson(Map<String, dynamic> json) =>
      _$SpardhaResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpardhaResultModelToJson(this);
}
