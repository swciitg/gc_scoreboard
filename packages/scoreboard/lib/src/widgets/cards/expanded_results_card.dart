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
    if (eventModel.results[0].secondaryScore == null) {
      return Container(
          height: (eventModel.results.length).toDouble() * 34,
          child: ListView.builder(
              itemCount: eventModel.results.length,
              itemBuilder: (context, index) {
                return NullSecondaryResultsCardItem(
                    eventModel.results[index].position,
                    eventModel.results[index].hostel,
                    eventModel.results[index].primaryScore);
              }));
    } else {
      return Container(
        child: Column(
          children: [
            SecondaryScoreResultsCardItem(
              eventModel.results[0].position,
              eventModel.results[0].hostel,
              eventModel.results[0].primaryScore,
              eventModel.results[1].secondaryScore,
            ),
            SecondaryScoreResultsCardItem(
              eventModel.results[1].position,
              eventModel.results[1].hostel,
              eventModel.results[1].primaryScore,
              eventModel.results[1].secondaryScore,
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
