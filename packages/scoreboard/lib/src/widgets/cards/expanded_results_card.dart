import 'package:flutter/material.dart';

import '../../globals/styles.dart';
import '../../models/event_model.dart';

// ignore: must_be_immutable
class ExpandedResultsCard extends StatelessWidget {
  final EventModel eventModel;
  ExpandedResultsCard({Key? key, required this.eventModel}) : super(key: key);

  var length = 0;

  void count() {
    for (int i = 0; i < eventModel.results.length.toInt(); i++) {
      length += eventModel.results[i].length.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    count();
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: length * 30,
        ),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: eventModel.results.length,
            itemBuilder: (context, index) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: eventModel.results[index].length * 30),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: eventModel.results[index].length,
                    itemBuilder: (context, subIndex) {
                      return scoreCardItem(
                          index + 1,
                          eventModel.results[index][subIndex].hostelName!,
                          eventModel.results[index][subIndex].primaryScore!,
                          eventModel.results[index][subIndex].secondaryScore);
                    }),
              );
            }));
  }

  Widget scoreCardItem(int position, String hostelName, String finalScore,
      String? secondaryScore) {
    final split = secondaryScore?.split(',');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 18,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 16,
                  height: 18,
                  child: Text(
                    '$position',
                    style: cardVenueStyle1,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 105,
                  child: Text(
                    overflow: TextOverflow.visible,
                    hostelName,
                    style: cardVenueStyle1,
                  ),
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
                  finalScore,
                  style: cardPostponedStyle,
                ),
                secondaryScore == null
                    ? Container()
                    : Row(
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            width: (split?.length.toDouble())! * 18,
                            child: ListView.builder(
                                itemCount: split?.length,
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    alignment: Alignment.centerRight,
                                    width: 18,
                                    child: Text(
                                      split![index],
                                      style: cardSecondaryScoreStyle,
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
