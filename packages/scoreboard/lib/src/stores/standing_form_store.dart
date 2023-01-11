import 'package:scoreboard/src/models/hostel_points.dart';
import 'package:scoreboard/src/models/standing_model.dart';
import '../globals/enums.dart';

class StandingFormStore {
  String? event;
  Category? category;

  List<HostelPoints>? standing = [];

  void addNewPosition() {
    standing?.add(HostelPoints());
  }

  void setPreData(StandingModel? standings) {
    if (standings!.standings != null && standings.standings!.isNotEmpty) {
      event = standings.event;
      standing = standings.standings;
    }
  }

  void clearStandings() {
    standing = [HostelPoints()];
  }
}
