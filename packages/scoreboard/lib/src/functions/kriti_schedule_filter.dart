import '../globals/enums.dart';
import '../models/kriti_models/kriti_event_model.dart';

List<KritiEventModel> kritiFilterSchedule({required List<KritiEventModel> input, required Cup cup, required Club club})
{

  List<KritiEventModel> output=[];
  output.addAll(input);
  output.retainWhere((element){
    if(cup !=Cup.overall && cup.cupName!=element.cup){
      return false;
    }
    if(club !=Club.overall && !element.clubs.contains(club.clubName)){
      return false;
    }
    return true;
  });
  return output;
}
