import 'package:json_annotation/json_annotation.dart';

import 'kriti_result_model.dart';
part 'kriti_event_model.g.dart';

@JsonSerializable(explicitToJson: true)
class KritiEventModel{
  @JsonKey(name: '_id')
  String? id;
  String event; // CP Contest
  String cup;
  String difficulty;
  double? points;
  DateTime date;
  List<String> clubs;
  String venue="";
  bool resultAdded=false;
  String? victoryStatement = '';
  List<KritiResultModel> results;
  String? posterEmail = '';
  String problemLink;

  KritiEventModel({
    this.id,
    required this.event,
    required this.cup,
    required this.difficulty,
    required this.date,
    required this.clubs,
    required this.venue,
    required this.resultAdded,
    required this.problemLink,
    this.results=const [],
    this.victoryStatement,
    this.posterEmail
  });

  factory KritiEventModel.fromJson(Map<String,dynamic> json) => _$KritiEventModelFromJson(json);
  Map<String,dynamic> toJson() => _$KritiEventModelToJson(this);

}