import 'package:json_annotation/json_annotation.dart';
import 'spardha_result_model.dart';
part 'spardha_event_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SpardhaEventModel {
  @JsonKey(name: '_id')
  String? id;
  String event; // Sprint
  String category; // Men/Women
  String stage; // Semi-Finals
  DateTime date;
  String status;
  String venue;
  List<String> hostels; // Participating hostels
  List<List<SpardhaResultModel>> results;
  String? posterEmail = '';
  bool resultAdded;
  String? victoryStatement = '';
  SpardhaEventModel({
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

  factory SpardhaEventModel.fromJson(Map<String,dynamic> json) => _$SpardhaEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpardhaEventModelToJson(this);

}