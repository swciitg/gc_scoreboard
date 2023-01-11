import 'package:flutter/material.dart';
import 'package:scoreboard/src/screens/spardha/add_standing.dart';
import 'package:scoreboard/src/widgets/schedule_page/add_button.dart';
import '../../globals/colors.dart';
import '../../models/standing_model.dart';
import '../../services/api.dart';
import '../../widgets/cards/standings_results_card.dart';
import '../../widgets/common/standings_app_bar.dart';
import '../err_reload.dart';

class SpardhaAdminStandingsPage extends StatefulWidget {
  const SpardhaAdminStandingsPage({Key? key}) : super(key: key);

  @override
  State<SpardhaAdminStandingsPage> createState() =>
      _SpardhaAdminStandingsPageState();
}

class _SpardhaAdminStandingsPageState extends State<SpardhaAdminStandingsPage> {

  rebuild(){
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddStanding()));
        },
        child: const AddButton(text: 'Add Standing', width: 175,

        ),
      ),
        backgroundColor: Themes.backgroundColor,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56), child: StandingsAppBar()),
        body: FutureBuilder<Map<String, dynamic>>(
          future: APIService(context).getSpardhaStandings(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
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
            else if(snapshot.hasError)
              {
                return ErrorReloadPage(apiFunction: rebuild,);
              }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
