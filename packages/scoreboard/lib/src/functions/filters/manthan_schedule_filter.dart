
import '../../globals/enums.dart';

List<dynamic> manthanFilterSchedule({required List<dynamic> input, required String module})
{
  List<dynamic> output=[];
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
