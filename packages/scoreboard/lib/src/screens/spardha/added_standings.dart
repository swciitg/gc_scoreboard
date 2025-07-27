import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';
import '../../models/standing_model.dart';
import '../../services/api.dart';
import '../../widgets/cards/results/standings_results_card.dart';
import '../../widgets/ui/shimmer.dart';
import '../../widgets/common/standings_app_bar.dart';
import '../../widgets/schedule_page/add_button.dart';
import '../../widgets/ui/err_reload.dart';
import 'forms/add_standing_form.dart';

class SpardhaAdminStandingsPage extends StatefulWidget {
  static const id = '/spardha/standings';
  const SpardhaAdminStandingsPage({super.key});

  @override
  State<SpardhaAdminStandingsPage> createState() =>
      _SpardhaAdminStandingsPageState();
}

class _SpardhaAdminStandingsPageState extends State<SpardhaAdminStandingsPage> {
  void reloadCallback() {
    // reload page
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(56), child: StandingsAppBar()),
      body: FutureBuilder<Map<String, dynamic>>(
        future: APIService(context).getStandings(competition: 'spardha'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ShowShimmer(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                });
          } else if (snapshot.hasData) {
            return snapshot.data!['event-wise'].length != 0
                ? ListView.builder(
                    itemCount: snapshot.data!['event-wise'].length,
                    itemBuilder: (context, index) {
                      return StandingsResultCard(
                          standingModel: StandingModel.fromJson(
                              snapshot.data!['event-wise'][index]));
                    })
                : Center(
                    child: Text("No Standings added", style: fontStyle1),
                  );
          }
          return ErrorReloadPage(
            apiFunction: reloadCallback,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddStanding()));
        },
        child: const AddButton(
          text: 'Add Standing',
          width: 175,
        ),
      ),
    );
  }
}
