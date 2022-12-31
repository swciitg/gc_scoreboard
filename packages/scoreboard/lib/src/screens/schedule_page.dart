import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/functions/filter_schedule.dart';
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
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
      return FutureBuilder<List<EventModel>>(
          future: APIService(context).getSpardhaSchedule(
              commonStore.viewType),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<EventModel> allSpardhaEventSchedules = snapshot.data!;
              return Observer(builder: (context) {
                List<EventModel> filteredEventSchedules = filterSchedule(
                    input: allSpardhaEventSchedules,
                    event: commonStore.selectedEvent,
                    date: commonStore.selectedDate,
                    hostel: commonStore.selectedHostel);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    children: [
                      const TopBar(),
                      const FilterBar(),
                      Expanded(
                          child: filteredEventSchedules.isNotEmpty
                              ? ListView.builder(
                                  itemCount: filteredEventSchedules.length,
                                  itemBuilder: (context, index) {
                                    return ScheduleCard(
                                        eventModel:
                                            filteredEventSchedules[index]);
                                  })
                              : Center(
                                  child: Text("No Schedule found",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Themes.kWhite)),
                                ))
                    ],
                  ),
                );
              });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
  }
}
