import 'package:json_annotation/json_annotation.dart';
part 'hostel_points.g.dart';

@JsonSerializable(explicitToJson: true)
class HostelPoints {
  String? hostelName;
  double? points;
  HostelPoints({this.hostelName, this.points});
  factory HostelPoints.fromJson(Map<String, dynamic> json) =>
      _$HostelPointsFromJson(json);

  Map<String, dynamic> toJson() => _$HostelPointsToJson(this);
}
