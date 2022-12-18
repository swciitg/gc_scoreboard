import 'package:scoreboard/src/models/result_model.dart';

class EventModel {
  String name; // Sprint
  String category; // Men/Women
  String stage; // Semi-finals
  DateTime date;
  List<ResultModel> results;
  EventModel({
    required this.name,
    required this.category,
    required this.stage,
    required this.date,
    required this.results,
  });
}
