import 'package:json_annotation/json_annotation.dart';
import 'manthan_result_model.dart';
part 'manthan_event_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ManthanEventModel {
  @JsonKey(name: '_id')
  String? id;
  String event; // Sprint
  String module; // Men/Women
  DateTime date;
  String venue;
  List<ManthanResultModel> results;
  String? posterEmail = '';
  bool resultAdded;
  String? victoryStatement = '';
  ManthanEventModel({
    this.id,
    required this.event,
    required this.module,
    required this.date,
    required this.venue,
    this.results = const [],
    this.resultAdded = false,
    this.victoryStatement = '',
  });

  factory ManthanEventModel.fromJson(Map<String,dynamic> json) => _$ManthanEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$ManthanEventModelToJson(this);

}