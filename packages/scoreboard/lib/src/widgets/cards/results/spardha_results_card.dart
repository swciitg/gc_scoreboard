import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../../globals/enums.dart';
import '../../../globals/styles.dart';
import '../../../stores/common_store.dart';
import '../../../models/spardha_models/spardha_event_model.dart';
import '../../../globals/colors.dart';
import '../card_event_details.dart';
import '../menu_item.dart';
import '../popup_menu.dart';
import 'score_card_item.dart';

class SpardhaResultsCard extends StatefulWidget {
  final EventModel eventModel;
  const SpardhaResultsCard({Key? key, required this.eventModel})
      : super(key: key);

  @override
  State<SpardhaResultsCard> createState() => _SpardhaResultsCardState();
}

class _SpardhaResultsCardState extends State<SpardhaResultsCard> {
  bool isExpanded = false;
  List<PopupMenuEntry> popupOptions = [
    optionsMenuItem('Edit', 'edit result', Themes.kWhite),
    const PopupMenuDivider(
      height: 2,
    ),
    optionsMenuItem('Delete', 'delete', Themes.errorRed),
  ];

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 186),
          child: PopupMenu(
            eventModel: widget.eventModel,
            items: commonStore.viewType == ViewType.admin ? popupOptions : [],
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Themes.cardColor2),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CardEventDetails(eventModel: widget.eventModel),
                    SizedBox(
                      // height: 24,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.emoji_events_outlined,
                                  color: Themes.warning,
                                  size: 12,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.eventModel.victoryStatement!,
                                    overflow: TextOverflow.visible,
                                    style: cardStageStyle1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Container(
                              height: 24,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Themes.kGrey),
                              width: 64,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                child: Row(
                                  children: [
                                    Text(
                                      isExpanded ? 'Less' : 'More',
                                      style: cardResultStyle1,
                                    ),
                                    Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_up_outlined
                                          : Icons.keyboard_arrow_down_outlined,
                                      size: 14,
                                      color: Themes.cardFontColor2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    isExpanded
                        ? Column(
                            children: [
                              const Divider(
                                height: 32,
                                color: Themes.bottomNavHighlightColor,
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 12,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: ExpandedSpardhaResultsCard(
                                    eventModel: widget.eventModel),
                              )
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

// ignore: must_be_immutable
class ExpandedSpardhaResultsCard extends StatelessWidget {
  final EventModel eventModel;
  ExpandedSpardhaResultsCard({Key? key, required this.eventModel})
      : super(key: key);

  var length = 0; // number of items in expanded card

  void count() {
    for (int i = 0; i < eventModel.results.length.toInt(); i++) {
      length += eventModel.results[i].length
          .toInt(); // adding number of hostels at each position
    }
  }

  @override
  Widget build(BuildContext context) {
    count();
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: length * 30,
        ),
        // listview for all positions
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: eventModel.results.length,
            itemBuilder: (context, index) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: eventModel.results[index].length * 30),
                // listview for all hostels at particular position
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
