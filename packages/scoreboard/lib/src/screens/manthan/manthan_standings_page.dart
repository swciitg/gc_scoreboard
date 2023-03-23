import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../functions/filters/manthan_standings_filter.dart';
import '../../stores/manthan_store.dart';
import '../../widgets/ui/err_reload.dart';
import '../../widgets/ui/shimmer.dart';
import '../../services/api.dart';
import '../../widgets/common/top_bar.dart';
import '../../widgets/filters/manthan_filter_bar.dart';
import '../../widgets/standings_page/standingboard.dart';
import 'package:provider/provider.dart';


class ManthanStandingsPage extends StatefulWidget {
  const ManthanStandingsPage({super.key});

  @override
  State<ManthanStandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<ManthanStandingsPage> {
  @override
  Widget build(BuildContext context) {
    var manthanStore = context.read<ManthanStore>();

    reloadCallback() {
      setState(() {});
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            const TopBar(),
            const ManthanFilterBar(),
            FutureBuilder<Map<String, dynamic>>(
              future: APIService(context).getManthanStandings(),
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
                    List<dynamic> filteredEventSchedules = filterManthanStandings(input: snapshot.data!, event: manthanStore.selectedEvent);
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
