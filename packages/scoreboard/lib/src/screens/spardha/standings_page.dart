import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scoreboard/src/widgets/common/shimmer.dart';
import '../../functions/filter_standings.dart';
import '../../services/api.dart';
import '../../stores/spardha_store.dart';
import '../../widgets/common/filter_bar.dart';
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
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            TopBar(),
            FilterBar(),
            FutureBuilder<Map<String, dynamic>>(
              future: APIService(context).getSpardhaStandings(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return Observer(builder: (context) {
                    List<dynamic> filteredEventSchedules = filterStandings(
                        input: snapshot.data!,
                        event: spardhaStore.selectedEvent,
                        category: spardhaStore.selectedCategory);
                    return Expanded(
                        child: StandingBoard(
                            hostelStandings: filteredEventSchedules));
                  });
                }
                return Expanded(
                    child: Center(
                  child: ShowShimmer(
                    height: 400,
                    width: MediaQuery.of(context).size.width,

                  ),
                ));
              },
            )
          ],
        ));
  }
}
