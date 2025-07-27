import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../functions/filters/sahyog_filter.dart';
import '../../globals/styles.dart';
import '../../services/api.dart';
import '../../stores/common_store.dart';
import '../../stores/sahyog_store.dart';
import '../../widgets/cards/results/kriti_result_card.dart';
import '../../widgets/ui/err_reload.dart';
import '../../widgets/ui/shimmer.dart';
import '../../widgets/common/top_bar.dart';
import '../../widgets/filters/sahyog_filter_bar.dart';

class SahyogResultsPage extends StatefulWidget {
  const SahyogResultsPage({super.key});

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
          FutureBuilder<List<dynamic>>(
              future: APIService(context)
                  .getResults(commonStore.viewType, competition: 'sahyog'),
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
                  return Observer(builder: (context) {
                    List<dynamic> filteredEventSchedules = sahyogFilter(
                        input: snapshot.data!,
                        difficulty: sahyogStore.difficulty,
                        club: sahyogStore.selectedClub);
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
