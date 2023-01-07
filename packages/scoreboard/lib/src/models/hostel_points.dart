import 'package:json_annotation/json_annotation.dart';
part 'hostel_points.g.dart';

@JsonSerializable(explicitToJson: true)
class HostelPoints{
String hostelName;
int points;
  HostelPoints(
      {
  required this.hostelName,
        required this.points
        });
  factory HostelPoints.fromJson(Map<String,dynamic> json) => _$HostelPointsFromJson(json);

  Map<String, dynamic> toJson() => _$HostelPointsToJson(this);
}
