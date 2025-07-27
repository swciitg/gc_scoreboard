import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../functions/filters/spardha_filter.dart';
import '../../globals/styles.dart';
import '../../services/api.dart';
import '../../stores/common_store.dart';
import '../../stores/spardha_store.dart';
import '../../widgets/cards/schedule/spardha_schedule_card.dart';
import '../../widgets/filters/spardha_filter_bar.dart';
import '../../widgets/ui/shimmer.dart';
import '../../widgets/common/top_bar.dart';
import '../../widgets/ui/err_reload.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    var spardhaStore = context.read<SpardhaStore>();

    reloadCallback() {
      // reload page
      setState(() {});
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TopBar(),
          const SpardhaFilterBar(),
          FutureBuilder<List<dynamic>>(
              future:
                  APIService(context).getSchedule(commonStore.viewType,competition: 'spardha'),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 300,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ShowShimmer(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                            ),
                          );
                        }),
                  );
                } else if (snapshot.hasData) {

                  return Observer(builder: (context) {
                    List<dynamic> filteredEventSchedules = spardhaFilter(
                        input: snapshot.data!,
                        event: spardhaStore.selectedEvent,
                        date: spardhaStore.selectedDate,
                        hostel: spardhaStore.selectedHostel);
                    return Expanded(
                        child: filteredEventSchedules.isNotEmpty
                            ? ListView.builder(
                                itemCount: filteredEventSchedules.length,
                                itemBuilder: (context, index) {
                                  return SpardhaScheduleCard(
                                      eventModel:
                                          filteredEventSchedules[index]);
                                })
                            : Center(
                                child: Text("No Schedule found",
                                    style: fontStyle1),
                              ));
                  });
                }
                return ErrorReloadPage(apiFunction: reloadCallback);
              })
        ],
      ),
    );
  }
}
