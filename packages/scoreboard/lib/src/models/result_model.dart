class ResultModel extends Comparable {
  int position;
  String? hostel;
  int? points;
  String? primaryScore;
  String? secondaryScore;
  ResultModel(
      {required this.position,
      this.hostel,
      this.points,
      this.primaryScore,
      this.secondaryScore});

  @override
  int compareTo(other) {
    return position.compareTo(other.position);
  }
}
