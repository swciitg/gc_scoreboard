import 'package:json_annotation/json_annotation.dart';
import 'spardha_result_model.dart';
part 'spardha_event_model.g.dart';

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
  List<List<ResultModel>> results;
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
    this.results = const [],
    this.resultAdded = false,
    this.victoryStatement = '',
  });

  factory EventModel.fromJson(Map<String,dynamic> json) => _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);

}