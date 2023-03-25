
import '../../globals/enums.dart';
import '../../models/manthan_models/manthan_event_model.dart';

List<ManthanEventModel> manthanFilterSchedule({required List<ManthanEventModel> input, required String module})
{
  List<ManthanEventModel> output=[];
  output.addAll(input);
  output.retainWhere((element){
    if(module == Module.overall.moduleName)
      {
        return true;
      }
    else if(module == element.module)
      {
        return true;
      }
    else
      {
        return false;
      }
  });
  return output;
}
