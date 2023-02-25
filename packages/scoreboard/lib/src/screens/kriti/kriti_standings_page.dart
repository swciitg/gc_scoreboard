import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../functions/kriti_standings_filter.dart';
import '../../stores/kriti_store.dart';
import '../../widgets/common/err_reload.dart';
import '../../widgets/common/shimmer.dart';
import '../../services/api.dart';
import '../../widgets/common/top_bar.dart';
import '../../widgets/standings_page/standingboard.dart';
import 'package:provider/provider.dart';

import '../../widgets/filters/kriti_filter_bar.dart';

class KritiStandingsPage extends StatefulWidget {
  const KritiStandingsPage({super.key});

  @override
  State<KritiStandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<KritiStandingsPage> {
  @override
  Widget build(BuildContext context) {
    var kritiStore = context.read<KritiStore>();

    reloadCallback() {
      setState(() {});
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            const TopBar(),
            const KritiFilterBar(),
            FutureBuilder<Map<String, dynamic>>(
              future: APIService(context).getKritiStandings(),
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
                    print(snapshot.data!);
                    List<dynamic> filteredEventSchedules = filterKritiStandings(input: snapshot.data!, event: kritiStore.selectedEvent);
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
