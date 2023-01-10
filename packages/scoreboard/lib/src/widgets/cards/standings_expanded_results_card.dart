import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoreboard/src/models/standing_model.dart';

import '../../models/event_model.dart';
import '../../globals/colors.dart';

class StandingsExpandedresultsCard extends StatelessWidget {
  final StandingModel standingModel;
  StandingsExpandedresultsCard({Key? key, required this.standingModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: standingModel.standings.length * 30,
        ),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: standingModel.standings.length,
            itemBuilder: (context, index) {
              return AthleticsResultsCardItem(
                  index + 1,
                  standingModel.standings[index].hostelName,
                  standingModel.standings[index].points.toString());
            }));
    ;
  }

  Widget AthleticsResultsCardItem(
      int position, String hostelName, String score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 18,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 16,
                  height: 18,
                  child: Text(
                    '${position}',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Themes.cardFontColor2),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  hostelName,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Themes.cardFontColor2),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 18,
            child: Text(
              '${score}',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Themes.cardFontColor3),
            ),
          )
        ],
      ),
    );
  }
}
