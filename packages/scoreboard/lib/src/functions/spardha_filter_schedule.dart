import '../globals/enums.dart';
import '../models/spardha_models/spardha_event_model.dart';

List<EventModel> filterSchedule({required List<EventModel> input, required String event, required String date, required Hostel hostel})
{

  List<EventModel> output=[];
  output.addAll(input);
  output.retainWhere((element){
    if(event!='Overall' && event!=element.event){
      return false;
    }
    String elementDateISOString = DateTime(element.date.year,element.date.month,element.date.day).toIso8601String();
    if(date.isNotEmpty && elementDateISOString != date){
      return false;
    }
    if(hostel!=Hostel.overall && !element.hostels.contains(hostel.hostelName)){
      return false;
    }
    return true;
  });
  return output;
}
