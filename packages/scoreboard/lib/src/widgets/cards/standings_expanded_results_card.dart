import 'package:flutter/material.dart';

import '../../globals/styles.dart';
import '../../models/standing_model.dart';

class StandingsExpandedresultsCard extends StatelessWidget {
  final StandingModel standingModel;
  const StandingsExpandedresultsCard({Key? key, required this.standingModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: standingModel.standings!.length * 30,
        ),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: standingModel.standings!.length,
            itemBuilder: (context, index) {
              return athleticsResultsCardItem(
                  index + 1,
                  standingModel.standings![index].hostelName!,
                  standingModel.standings![index].points.toString());
            }));
  }

  Widget athleticsResultsCardItem(
      int position, String hostelName, String score) {
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
                Text(
                  hostelName,
                  style: cardVenueStyle1,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 18,
            child: Text(
              score,
              style: cardPostponedStyle,
            ),
          )
        ],
      ),
    );
  }
}
