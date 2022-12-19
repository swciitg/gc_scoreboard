import 'package:scoreboard/src/models/result_model.dart';

class EventModel {
  String name; // Sprint
  String group; // Athletics
  String category; // Men/Women
  String stage; // Semi-finals
  DateTime date;
  String venue;
  List<String> hostels; // Participating hostels
  List<ResultModel> results;
  EventModel({
    required this.name,
    required this.group,
    required this.category,
    required this.stage,
    required this.date,
    required this.venue,
    required this.results,
    required this.hostels
  });
}
