import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../globals/colors.dart';
import '../../models/standing_model.dart';
import '../../services/api.dart';
import '../../widgets/cards/standings_results_card.dart';
import '../../widgets/common/shimmer.dart';
import '../../widgets/common/standings_app_bar.dart';
import '../../widgets/schedule_page/add_button.dart';
import '../../widgets/common/err_reload.dart';
import 'forms/add_standing_form.dart';

class SpardhaAdminStandingsPage extends StatefulWidget {
  static const id = '/spardha/standings';
  const SpardhaAdminStandingsPage({Key? key}) : super(key: key);

  @override
  State<SpardhaAdminStandingsPage> createState() =>
      _SpardhaAdminStandingsPageState();
}

class _SpardhaAdminStandingsPageState extends State<SpardhaAdminStandingsPage> {

  reloadCallback(){ // reload page
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Themes.backgroundColor,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56), child: StandingsAppBar()),
        body: FutureBuilder<Map<String, dynamic>>(
          future: APIService(context).getSpardhaStandings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 200,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: ShowShimmer(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                      ),
                    );
                  });
            }
            else if (snapshot.hasData) {
              print(snapshot.data);
              return snapshot.data!['event-wise'].length!=0 ? ListView.builder(
                  itemCount: snapshot.data!['event-wise'].length,
                  itemBuilder: (context, index) {
                    print('asdfghjk');
                    print(StandingModel.fromJson(
                        snapshot.data!['event-wise'][index]));
                    return StandingsResultCard(
                        standingModel: StandingModel.fromJson(
                            snapshot.data!['event-wise'][index]));
                  }) : Center(child: Text("No Standings added",style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Themes.kWhite)),);
            }
            return ErrorReloadPage(apiFunction: reloadCallback,);
          },
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddStanding()));
        },
        child: const AddButton(text: 'Add Standing', width: 175,

        ),
      ),
    );
  }
}
