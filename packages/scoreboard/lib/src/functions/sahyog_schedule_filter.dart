import '../globals/enums.dart';
import '../models/sahyog_models/sahyog_event_model.dart';


List<SahyogEventModel> sahyogFilterSchedule({required List<SahyogEventModel> input, required String difficulty, required SahyogClub club})
{
  List<SahyogEventModel> output=[];
  output.addAll(input);
  output.retainWhere((element){
    if(difficulty != 'Overall' && difficulty!=element.difficulty){
      return false;
    }
    if(club !=SahyogClub.overall && !element.clubs.contains(club.clubName)){
      return false;
    }
    return true;
  });
  return output;
}
