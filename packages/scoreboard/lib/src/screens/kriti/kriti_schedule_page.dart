import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';


import '../../functions/kriti_schedule_filter.dart';
import '../../globals/styles.dart';
import '../../models/kriti_models/kriti_event_model.dart';
import '../../services/api.dart';
import '../../stores/common_store.dart';
import '../../stores/kriti_store.dart';
import '../../widgets/common/err_reload.dart';
import '../../widgets/common/shimmer.dart';
import '../../widgets/common/top_bar.dart';
import '../../widgets/common/kriti_filter_bar.dart';
import '../../widgets/cards/kriti_schedule_card.dart';

class KritiSchedulePage extends StatefulWidget {
  const KritiSchedulePage({super.key});

  @override
  State<KritiSchedulePage> createState() => _KritiSchedulePageState();
}

class _KritiSchedulePageState extends State<KritiSchedulePage> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    var kritiStore = context.read<KritiStore>();

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
          const KritiFilterBar(),
          FutureBuilder<List<KritiEventModel>>(
              future: APIService(context).getKritiSchedule(commonStore.viewType),
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
                  List<KritiEventModel> allKritiEventSchedules = snapshot.data!;
                  return Observer(builder: (context) {
                    List<KritiEventModel> filteredEventSchedules = kritiFilterSchedule(input: allKritiEventSchedules, cup: kritiStore.selectedCup, club: kritiStore.selectedClub);
                    return Expanded(
                        child: filteredEventSchedules.isNotEmpty
                            ? ListView.builder(
                            itemCount: filteredEventSchedules.length,
                            itemBuilder: (context, index) {
                              return KritiScheduleCard(eventModel: filteredEventSchedules[index]);
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
