import 'package:json_annotation/json_annotation.dart';

import 'hostel_points.dart';
part 'standing_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StandingModel {
  @JsonKey(name: '_id')
  String? id;
  String? event;
  String? category;
  List<HostelPoints>? standings;
  StandingModel({this.event, this.category, this.standings});
  factory StandingModel.fromJson(Map<String, dynamic> json) =>
      _$StandingModelFromJson(json);

  Map<String, dynamic> toJson() => _$StandingModelToJson(this);
}
