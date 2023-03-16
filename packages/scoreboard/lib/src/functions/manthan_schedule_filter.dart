import 'package:scoreboard/src/models/manthan_models/manthan_event_model.dart';
import '../globals/enums.dart';

List<ManthanEventModel> manthanFilterSchedule({required List<ManthanEventModel> input, required String module})
{

  List<ManthanEventModel> output=[];
  output.addAll(input);
  output.retainWhere((element){
    if(module != Module.overall && module!= element.module){
      return false;
    }
    return true;
  });
  return output;
}
