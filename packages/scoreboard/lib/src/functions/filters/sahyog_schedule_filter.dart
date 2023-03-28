import '../../globals/enums.dart';


List<dynamic> sahyogFilterSchedule({required List<dynamic> input, required String difficulty, required SahyogClub club})
{
  List<dynamic> output=[];
  output.addAll(input);
  output.retainWhere((element){
    if(difficulty != 'Overall' && difficulty!=element['difficulty']){
      return false;
    }
    if(club !=SahyogClub.overall && !element['clubs'].contains(club.clubName)){
      return false;
    }
    return true;
  });
  return output;
}
