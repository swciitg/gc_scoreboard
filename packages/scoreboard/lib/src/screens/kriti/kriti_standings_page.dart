import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../widgets/common/err_reload.dart';
import '../../widgets/common/shimmer.dart';
import '../../functions/filter_standings.dart';
import '../../services/api.dart';
import '../../stores/spardha_store.dart';
import '../../widgets/common/filter_bar.dart';
import '../../widgets/common/top_bar.dart';
import '../../widgets/standings_page/standingboard.dart';
import 'package:provider/provider.dart';

class KritiStandingsPage extends StatefulWidget {
  const KritiStandingsPage({super.key});

  @override
  State<KritiStandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<KritiStandingsPage> {
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
            const FilterBar(),
            FutureBuilder<Map<String, dynamic>>(
              future: APIService(context).getSpardhaStandings(),
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
