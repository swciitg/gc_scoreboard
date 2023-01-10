import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import '../../models/standing_model.dart';
import '../../services/api.dart';
import '../../widgets/cards/standings_results_card.dart';
import '../../widgets/common/standings_app_bar.dart';

class SpardhaAdminStandingsPage extends StatefulWidget {
  const SpardhaAdminStandingsPage({Key? key}) : super(key: key);

  @override
  State<SpardhaAdminStandingsPage> createState() =>
      _SpardhaAdminStandingsPageState();
}

class _SpardhaAdminStandingsPageState extends State<SpardhaAdminStandingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Themes.backgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56), child: StandingsAppBar()),
        body: FutureBuilder<Map<String, dynamic>>(
          future: APIService(context).getSpardhaStandings(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              // AthleticsresultCard(
              //   standingModel:
              //       StandingModel.fromJson(snapshot.data!['event-wise'][0]),
              // );
              return ListView.builder(
                  itemCount: snapshot.data!['event-wise'].length,
                  itemBuilder: (context, index) {
                    print('asdfghjk');
                    print(StandingModel.fromJson(
                        snapshot.data!['event-wise'][index]));
                    return StandingsResultCard(
                        standingModel: StandingModel.fromJson(
                            snapshot.data!['event-wise'][index]));
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
