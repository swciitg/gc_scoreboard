
import '../globals/enums.dart';
import 'gc_filter.dart';

List<dynamic> filterStandings({required Map<String,dynamic> input, required String event, required Category category})
{

  List<dynamic> output=[];
  if(event == 'Overall'){
    output = filterGCStandings(category, input['overall']);
  }
  else {
    for(int i=0;i<input["event-wise"].length;i++){
      var element = input["event-wise"][i];

      if(element["event"]==event && element["category"] == category.categoryName){
        output.addAll(element["standings"]);
        break;
      }
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