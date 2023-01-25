import '../globals/constants.dart';
import '../globals/enums.dart';

List<dynamic> filterGCStandings(Category category, List<dynamic> input) {
  List<dynamic> output = [];
  for (var element in input) {
    if (menHostel.contains(element['hostelName']) && category == Category.men) {
      output.add(element);
    } else if (womenHostel.contains(element['hostelName']) &&
        category == Category.women) {
      output.add(element);
    }
  }

  output.sort((e1, e2) {
    if (e1['points'] > e2['points']) {
      return -1;
    } else {
      return 1;
    }
  });
  return output;
}
