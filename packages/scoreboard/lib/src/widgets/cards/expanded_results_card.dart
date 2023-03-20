import 'package:flutter/material.dart';

import '../../models/spardha_models/spardha_event_model.dart';
import 'score_card_item.dart';

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
                      return ScoreCardItem(
                          position: index + 1,
                          hostelName:
                              eventModel.results[index][subIndex].hostelName!,
                          finalScore:
                              eventModel.results[index][subIndex].primaryScore!,
                          secondaryScore: eventModel
                              .results[index][subIndex].secondaryScore);
                    }),
              );
            }));
  }
}
