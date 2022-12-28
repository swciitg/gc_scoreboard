class ResultModel {
  // int position;
  String hostel;
  int points;
  String primaryScore;
  String? secondaryScore;
  ResultModel({
    // required this.position,
    required this.hostel,
    required this.points,
    required this.primaryScore,
    this.secondaryScore,
  });
}
