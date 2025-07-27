import 'package:flutter/material.dart';
import '../../../globals/colors.dart';
import '../../../globals/styles.dart';
import '../../../models/standing_model.dart';
import '../menu_item.dart';
import '../standing_popup_menu.dart';
import 'score_card_item.dart';


class StandingsResultCard extends StatefulWidget {
  final StandingModel standingModel;
  const StandingsResultCard({super.key, required this.standingModel});

  @override
  State<StandingsResultCard> createState() => _StandingsResultCardState();
}

class _StandingsResultCardState extends State<StandingsResultCard> {
  List<PopupMenuEntry> popupOptions = [
    optionsMenuItem('Edit', 'edit standings', Themes.kWhite),
    const PopupMenuDivider(
      height: 2,
    ),
    optionsMenuItem('Delete', 'delete', Themes.errorRed),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 50),
          child: StandingPopup(
            items: popupOptions,
            standingModel: widget.standingModel,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Themes.cardColor2),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Column(children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              child: SizedBox(
                                height: 28,
                                child: Text(widget.standingModel.event!,
                                    style: cardEventStyle),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: Text(widget.standingModel.category!,
                                  style: cardCategoryStyle),
                            ),
                          ],
                        ),
                      ),
                    ]),
                    Column(
                      children: [
                        const Divider(
                          height: 32,
                          color: Themes.bottomNavHighlightColor,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 26,
                                  ),
                                  Text(
                                    'Hostel',
                                    style: cardResultStyle2,
                                  ),
                                ],
                              ),
                              Text(
                                'Score',
                                style: cardResultStyle2,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight:
                                    widget.standingModel.standings!.length * 30,
                              ),
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      widget.standingModel.standings!.length,
                                  itemBuilder: (context, index) {
                                    return ScoreCardItem(
                                        position: index + 1,
                                        hostelName: widget.standingModel
                                            .standings![index].hostelName!,
                                        finalScore: widget.standingModel
                                            .standings![index].points
                                            .toString());
                                  })),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
