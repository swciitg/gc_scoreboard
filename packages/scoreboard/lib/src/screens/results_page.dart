import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../functions/filter_schedule.dart';
import '../globals/colors.dart';

import '../services/api.dart';
import '../stores/common_store.dart';
import '../widgets/cards/results_card.dart';
import '../models/event_model.dart';
import '../widgets/common/top_bar.dart';
import '../widgets/common/filter_bar.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return FutureBuilder<List<EventModel>>(
        future: APIService(context).getSpardhaResults(
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
                              return ResultsCard(
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
