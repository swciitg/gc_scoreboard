import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/event_model.dart';
import '../../globals/colors.dart';

class ExpandedResultsCard extends StatelessWidget {
  final EventModel eventModel;
  ExpandedResultsCard({Key? key, required this.eventModel}) : super(key: key);

  int length = 0;

  @override
  void count() {
    for (int i = 0; i < eventModel.results.length.toInt(); i++) {
      length += eventModel.results[i].length.toInt();
    }
  }

  Widget build(BuildContext context) {
    count();
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: length * 30,
        ),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: eventModel.results.length,
            itemBuilder: (context, index) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: eventModel.results[index].length * 30),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: eventModel.results[index].length,
                    itemBuilder: (context, subIndex) {
                      return eventModel.results[0][0].secondaryScore == null
                          ? NullSecondaryResultsCardItem(
                              index + 1,
                              eventModel.results[index][subIndex].hostelName!,
                              eventModel.results[index][subIndex].primaryScore!)
                          : SecondaryScoreResultsCardItem(
                              index + 1,
                              eventModel.results[index][subIndex].hostelName!,
                              eventModel.results[index][subIndex].primaryScore!,
                              eventModel
                                  .results[index][subIndex].secondaryScore);
                    }),
              );
            }));
  }

  Widget NullSecondaryResultsCardItem(
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

  Widget SecondaryScoreResultsCardItem(int position, String hostelName,
      String finalScore, String? secondaryScore) {
    final split = secondaryScore?.split(',');
    print(split);

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
