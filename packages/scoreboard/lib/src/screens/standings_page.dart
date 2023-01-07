import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scoreboard/src/functions/filter_standings.dart';
import 'package:scoreboard/src/widgets/common/top_bar.dart';
import '../widgets/common/filter_bar.dart';
import '../widgets/standings_page/standingboard.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/functions/filter_schedule.dart';
import 'package:scoreboard/src/services/api.dart';
import 'package:scoreboard/src/stores/common_store.dart';

class StandingsPage extends StatefulWidget {
  const StandingsPage({super.key});

  @override
  State<StandingsPage> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<StandingsPage> {

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: FutureBuilder<Map<String,dynamic>>(
          future: APIService(context).getSpardhaStandings(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              print(snapshot.data);
              return Column(
                children: [
                  TopBar(),
                  FilterBar(),
                  Observer(builder: (context){
                    List<dynamic> filteredEventSchedules = filterStandings(input: snapshot.data!, event: commonStore.selectedEvent, category: commonStore.selectedCategory);
                    return Expanded(child: StandingBoard(hostelStandings: filteredEventSchedules));
                  })
                ],
              );
            }
            return Center(child: CircularProgressIndicator(),);
          },
        )
      );
  }
}
