import '../globals/enums.dart';

List<dynamic> filterStandings({required Map<String,dynamic> input, required String event, required Category category})
{
  if(category == Category.overall && event == 'Overall'){
    return input["overall"];
  }
  List<dynamic> output=[];
  for(int i=0;i<input["event-wise"].length;i++){
    var element = input["event-wise"][i];
    if(element["event"]==event && element["category"] == category.categoryName){
      output.addAll(element["standings"]);
      break;
    }
  }
  print(output);
  return output;
}