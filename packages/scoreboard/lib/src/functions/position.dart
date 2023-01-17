import '../globals/constants.dart';
import '../globals/enums.dart';

String getPosition(int index) {
  String answer = '';
  if (index == 0) {
    answer = '1st';
  } else if (index == 1) {
    answer = '2nd';
  } else if (index == 2) {
    answer = '3rd';
  } else {
    answer = '${index + 1}th';
  }

  return '$answer Position';
}

List<String> getHostel(Category? category) {
  if (category == Category.men) {
    return menHostel;
  } else if (category == Category.women) {
    return womenHostel;
  }

  return menHostel + womenHostel;
}
