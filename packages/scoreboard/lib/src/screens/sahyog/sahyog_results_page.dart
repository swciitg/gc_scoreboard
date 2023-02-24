import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/widgets/common/sahyog_filter_bar.dart';
import '../../functions/sahyog_schedule_filter.dart';
import '../../globals/styles.dart';
import '../../models/sahyog_models/sahyog_event_model.dart';
import '../../services/api.dart';
import '../../stores/common_store.dart';
import '../../stores/sahyog_store.dart';
import '../../widgets/cards/kriti_result_card.dart';
import '../../widgets/common/err_reload.dart';
import '../../widgets/common/shimmer.dart';
import '../../widgets/common/top_bar.dart';

class SahyogResultsPage extends StatefulWidget {
  const SahyogResultsPage({Key? key}) : super(key: key);

  @override
  State<SahyogResultsPage> createState() => _SahyogResultsPageState();
}

class _SahyogResultsPageState extends State<SahyogResultsPage> {
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
        children: [
          const TopBar(),
          const SahyogFilterBar(),
          FutureBuilder<List<SahyogEventModel>>(
              future: APIService(context).getSahyogResults(commonStore.viewType),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 200,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ShowShimmer(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                            ),
                          );
                        }),
                  );
                } else if (snapshot.hasData) {
                  List<SahyogEventModel> allSahyogResults = snapshot.data!;
                  return Observer(builder: (context) {
                    List<SahyogEventModel> filteredEventSchedules = sahyogFilterSchedule(input: allSahyogResults, difficulty: sahyogStore.difficulty, club: sahyogStore.selectedClub);
                    return Expanded(
                        child: filteredEventSchedules.isNotEmpty
                            ? ListView.builder(
                            itemCount: filteredEventSchedules.length,
                            itemBuilder: (context, index) {
                              return KritiResultCard(
                                  eventModel:
                                  filteredEventSchedules[index]);
                            })
                            : Center(
                          child:
                          Text("No Result found", style: fontStyle1),
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
