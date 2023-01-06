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
