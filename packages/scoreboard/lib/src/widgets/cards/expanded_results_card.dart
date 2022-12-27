import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/event_model.dart';
import '../../globals/themes.dart';

class ExpandedResultsCard extends StatelessWidget {
  final EventModel eventModel;
  const ExpandedResultsCard({Key? key, required this.eventModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (eventModel.winners[0].secondaryScore == null) {
      return Container(
          height: (eventModel.winners.length).toDouble() * 34,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: eventModel.winners.length,
              itemBuilder: (context, index) {
                return NullSecondaryResultsCardItem(
                    index+1,
                    eventModel.winners[index].hostel,
                    eventModel.winners[index].primaryScore);
              }));
    } else {
      return Container(
        child: Column(
          children: [
            SecondaryScoreResultsCardItem(
              1,
              eventModel.winners[0].hostel,
              eventModel.winners[0].primaryScore,
              eventModel.winners[0].secondaryScore,
            ),
            SecondaryScoreResultsCardItem(
              2,
              eventModel.winners[1].hostel,
              eventModel.winners[1].primaryScore,
              eventModel.winners[1].secondaryScore,
            ),
          ],
        ),
      );
    }
  }

  Widget NullSecondaryResultsCardItem(
      int position, String hostelName, String score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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

  Widget SecondaryScoreResultsCardItem(int position, String hostelName,
      String finalScore, String? secondaryScore) {
    final split = secondaryScore?.split(',');
    print(split);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
            child: Row(
              children: [
                Text(
                  '${finalScore}',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Themes.cardFontColor3),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  width: (split?.length.toDouble())! * 18,
                  child: ListView.builder(
                      itemCount: split?.length,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.centerRight,
                          width: 18,
                          child: Text(
                            '${split![index]}',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Themes.cardFontColor1),
                          ),
                        );
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
