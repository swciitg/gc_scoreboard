import 'package:scoreboard/src/models/result_model.dart';

class EventModel {
  String event; // Sprint
  String category; // Men/Women
  String stage;// Semi-finals
  String posterEmail;
  String fieldStatus;
  DateTime date;
  String venue;
  List<String> hostels; // Participating hostels
  List<ResultModel> winners = [];
  EventModel({
    required this.event,
    required this.category,
    required this.stage,
    required this.posterEmail,
    required this.fieldStatus,
    required this.date,
    required this.venue,
    required this.hostels
  });
}
