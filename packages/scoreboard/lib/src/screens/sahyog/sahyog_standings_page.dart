import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../functions/sahyog_standings_filter.dart';
import '../../services/api.dart';
import '../../stores/sahyog_store.dart';
import '../../widgets/common/err_reload.dart';
import '../../widgets/filters/sahyog_filter_bar.dart';
import '../../widgets/common/shimmer.dart';
import '../../widgets/common/top_bar.dart';
import '../../widgets/standings_page/standingboard.dart';

class SahyogStandingsPage extends StatefulWidget {
  const SahyogStandingsPage({Key? key}) : super(key: key);

  @override
  State<SahyogStandingsPage> createState() => _SahyogStandingsPageState();
}

class _SahyogStandingsPageState extends State<SahyogStandingsPage> {

  @override
  Widget build(BuildContext context) {
    var sahyogStore = context.read<SahyogStore>();

    reloadCallback() {
      setState(() {});
    }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            const TopBar(),
            const SahyogFilterBar(),
            FutureBuilder<Map<String, dynamic>>(
              future: APIService(context).getSahyogStandings(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: ShowShimmer(
                            height: 400,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ));
                } else if (snapshot.hasData) {
                  return Observer(builder: (context) {
                    List<dynamic> filteredEventSchedules = filterSahyogStandings(input: snapshot.data!, event: sahyogStore.selectedEvent);
                    return Expanded(
                        child: StandingBoard(
                            hostelStandings: filteredEventSchedules));
                  });
                }
                return ErrorReloadPage(apiFunction: reloadCallback);
              },
            )
          ],
        ));
  }
}
