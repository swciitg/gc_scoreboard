import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/globals/enums.dart';
import 'package:scoreboard/src/services/api.dart';
import 'package:scoreboard/src/stores/common_store.dart';
import '../models/event_model.dart';
import '../widgets/cards/schedule_card.dart';
import '../widgets/common/filter_bar.dart';
import '../widgets/common/top_bar.dart';
import '../globals/colors.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {

  EventModel eventModel = EventModel(
      event: 'Badminton Doubles',
      category: 'Men',
      stage: 'Quarter-Final',
      date: DateTime.now(),
      venue: 'Table Tennis Court, Old SAC',
      hostels: [
        'Married Scholars',
        'Brahmaputra',
      ], status: 'ok', results: [], resultAdded: false);

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();

    return Observer(
      builder: (context) {
        return FutureBuilder<List<EventModel>>(
            future: APIService(context).getSpardhaSchedule(commonStore.viewType, commonStore.selectedDate),
            builder: (context,snapshot){
              if(snapshot.hasData){
                List<EventModel> allSpardhaEventSchedules = snapshot.data!;
                return Observer(
                    builder: (context){
                    List<EventModel> filteredEventSchedules=[];
                    filteredEventSchedules.addAll(allSpardhaEventSchedules);
                    filteredEventSchedules.retainWhere((element){
                      // print(commonStore.selectedDate + " " + element.date.toIso8601String());
                      if(commonStore.selectedEvent!='Overall' && commonStore.selectedEvent!=element.event){
                        return false;
                      }
                      String elementDateISOString = DateTime(element.date.year,element.date.month,element.date.day).toIso8601String();
                      if(commonStore.selectedDate.isNotEmpty && elementDateISOString != commonStore.selectedDate){
                        return false;
                      }
                      if(commonStore.selectedHostel!=Hostel.overall && !element.hostels.contains(commonStore.selectedHostel.hostelName)){
                        return false;
                      }
                      return true;
                    });
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        child: Column(
                          children: [
                            const TopBar(),
                            FilterBar(),
                            Expanded(
                              child: filteredEventSchedules.length>0 ? ListView.builder(
                                  itemCount: filteredEventSchedules.length,
                                  itemBuilder: (context,index){
                                    return ScheduleCard(eventModel: filteredEventSchedules[index]);
                                  }
                              ) : Center(child: Text("No Schedule found",style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Themes.kWhite)
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                    );
                });
              }
              return const Center(child: CircularProgressIndicator(),);
            }
        );
      }
    );
  }
}
