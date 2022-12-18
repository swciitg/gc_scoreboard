class ResultModel {
  int position;
  String hostel;
  int points;
  int primaryScore;
  int? secondaryScore;
  ResultModel({
    required this.position,
    required this.hostel,
    required this.points,
    required this.primaryScore,
    this.secondaryScore,
  });
}
