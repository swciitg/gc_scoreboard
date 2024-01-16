import '../../globals/enums.dart';

List<dynamic> kritiFilter({required List<dynamic> input, required Cup cup, required Club club})
{

  List<dynamic> output=[];
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
