
import '../../../functions/filter_men_women.dart';
import '../../../globals/enums.dart';

List<dynamic> filterKritiStandings({required Map<String,dynamic> input, required String event})
{

  List<dynamic> output=[];
  if(event == 'Overall'){
    output=input['overall'];
  }
  else {
    for(int i=0;i<input["event-wise"].length;i++){
      var element = input["event-wise"][i];

      if(element["event"]==event){
        output.addAll(element["results"]);
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