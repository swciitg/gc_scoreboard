import 'sahyog_result_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sahyog_event_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SahyogEventModel{
  @JsonKey(name: '_id')
  String? id;
  String event; // CP Contest
  String difficulty;
  double? points;
  DateTime date;
  List<String> clubs;
  String venue="";
  bool resultAdded=false;
  String? victoryStatement = '';
  List<SahyogResultModel> results;
  String? posterEmail = '';
  String problemLink;

  SahyogEventModel({
    this.id,
    required this.event,
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

  factory SahyogEventModel.fromJson(Map<String,dynamic> json) => _$SahyogEventModelFromJson(json);
  Map<String,dynamic> toJson() => _$SahyogEventModelToJson(this);

}