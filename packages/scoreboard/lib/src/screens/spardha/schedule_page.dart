import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../functions/filter_schedule.dart';
import '../../globals/colors.dart';
import '../../models/event_model.dart';
import '../../services/api.dart';
import '../../stores/common_store.dart';
import '../../stores/spardha_store.dart';
import '../../widgets/cards/schedule_card.dart';
import '../../widgets/common/filter_bar.dart';
import '../../widgets/common/shimmer.dart';
import '../../widgets/common/top_bar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    var spardhaStore = context.read<SpardhaStore>();
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            const TopBar(),
            const FilterBar(),
            FutureBuilder<List<EventModel>>(
                future: APIService(context).getSpardhaSchedule(
                    commonStore.viewType),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return Expanded(
                    child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 300,
                            child: ShowShimmer(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                            ),
                          );
                        }),
                  );
                  }
                  List<EventModel> allSpardhaEventSchedules = snapshot.data!;
                  return Observer(
                      builder: (context) {
                        List<EventModel> filteredEventSchedules = filterSchedule(
                            input: allSpardhaEventSchedules,
                            event: spardhaStore.selectedEvent,
                            date: spardhaStore.selectedDate,
                            hostel: spardhaStore.selectedHostel);
                        return Expanded(
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
                            ));
                      }
                  );
                }
            )
          ],
        ),
      );
  }
}
