import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../functions/filters/sahyog_filter.dart';
import '../../globals/styles.dart';
import '../../services/api.dart';
import '../../stores/common_store.dart';
import '../../stores/sahyog_store.dart';
import '../../widgets/cards/schedule/kriti_schedule_card.dart';
import '../../widgets/ui/err_reload.dart';
import '../../widgets/filters/sahyog_filter_bar.dart';
import '../../widgets/ui/shimmer.dart';
import '../../widgets/common/top_bar.dart';

class SahyogSchedulePage extends StatefulWidget {
  const SahyogSchedulePage({Key? key}) : super(key: key);

  @override
  State<SahyogSchedulePage> createState() => _SahyogSchedulePageState();
}

class _SahyogSchedulePageState extends State<SahyogSchedulePage> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    var sahyogStore = context.read<SahyogStore>();

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
          const SahyogFilterBar(),
          FutureBuilder<List<dynamic>>(
              future: APIService(context).getSchedule(commonStore.viewType,competition: 'sahyog'),
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
                    List<dynamic> filteredEventSchedules = sahyogFilter(input: snapshot.data!, difficulty: sahyogStore.difficulty, club: sahyogStore.selectedClub);

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
