import 'package:scoreboard/src/models/result_model.dart';

class EventModel {
  String event; // Sprint
  String category; // Men/Women
  String stage; // Semi-finals
  String posterEmail= '';
  String status;
  bool resultAdded = false;
  DateTime date;
  String venue;
  List<String> hostels; // Participating hostels
  List<ResultModel> winners;
  EventModel({
    required this.event,
    required this.category,
    required this.stage,
    required this.date,
    required this.venue,
    required this.hostels,
    required this.status,
    required this.winners
  });
}