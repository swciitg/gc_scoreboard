import 'package:scoreboard/src/models/result_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EventModel {
  @JsonKey(name: '_id')
  String? id;
  String event; // Sprint
  String category; // Men/Women
  String stage; // Semi-Finals
  DateTime date;
  String status;
  String venue;
  List<String> hostels; // Participating hostels
  List<ResultModel> results;
  String? posterEmail = '';
  bool resultAdded;
  String? victoryStatement = '';

  EventModel({
    this.id,
    required this.event,
    required this.category,
    required this.stage,
    required this.date,
    required this.venue,
    required this.hostels,
    required this.status,
    required this.results,
    required this.resultAdded,
    this.victoryStatement,
    this.posterEmail
  });

  factory EventModel.fromJson(Map<String,dynamic> json) => _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);

}