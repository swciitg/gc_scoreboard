
import 'result_model.dart';

class EventModel {
  String event; // Sprint
  String category; // Men/Women
  String stage; // Semi-finals
  DateTime date;
  String status;
  String venue;
  List<String> hostels; // Participating hostels
  List<List<ResultModel>> winners;
  String? posterEmail = '';
  bool resultAdded;
  String? victoryStatement = '';
  EventModel({
    required this.event,
    required this.category,
    required this.stage,
    required this.date,
    required this.venue,
    required this.hostels,
    required this.status,
    required this.winners,
    required this.resultAdded,
    this.victoryStatement,
    this.posterEmail
  });
}