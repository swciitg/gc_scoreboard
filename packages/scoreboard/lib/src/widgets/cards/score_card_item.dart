import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../globals/enums.dart';
import '../../globals/styles.dart';
import '../../stores/common_store.dart';

class ScoreCardItem extends StatelessWidget {
  final int position;
  final String hostelName;
  final String finalScore;
  String? secondaryScore;

  ScoreCardItem(
      {super.key,
      required this.position,
      required this.hostelName,
      required this.finalScore,
      this.secondaryScore});

  @override
  Widget build(BuildContext context) {
    final split = secondaryScore?.split(',');
    var commonStore = context.read<CommonStore>();
    bool isWide = (commonStore.competition == Competitions.kriti ||
        commonStore.competition == Competitions.sahyog);
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
                  width: isWide
                      ? MediaQuery.of(context).size.width - 120
                      : MediaQuery.of(context).size.width - 210,
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
                            width: (split?.length.toDouble())! * 36,
                            child: ListView.builder(
                                itemCount: split?.length,
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    alignment: Alignment.centerRight,
                                    width: 36,
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
