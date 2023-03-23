import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../widgets/common/err_reload.dart';
import '../../widgets/common/shimmer.dart';
import '../../functions/spardha_filter_standings.dart';
import '../../services/api.dart';
import '../../stores/spardha_store.dart';
import '../../widgets/filters/spardha_filter_bar.dart';
import '../../widgets/common/top_bar.dart';
import '../../widgets/standings_page/standingboard.dart';
import 'package:provider/provider.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({super.key});

  @override
  State<StandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {
  @override
  Widget build(BuildContext context) {
    var spardhaStore = context.read<SpardhaStore>();

    reloadCallback() {
      // reload page
      setState(() {});
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            const TopBar(),
            const SpardhaFilterBar(),
            FutureBuilder<Map<String, dynamic>>(
              future: APIService(context).getStandings(competition: 'spardha'),
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
                    List<dynamic> filteredEventSchedules = filterStandings(
                        input: snapshot.data!,
                        event: spardhaStore.selectedEvent,
                        category: spardhaStore.selectedCategory);
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
