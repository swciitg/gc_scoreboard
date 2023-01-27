import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../globals/enums.dart';
import '../../globals/styles.dart';
import '../../stores/common_store.dart';
import '../../widgets/cards/expanded_results_card.dart';
import '../../models/spardha_models/spardha_event_model.dart';
import '../../globals/colors.dart';
import 'card_event_details.dart';
import 'menu_item.dart';
import 'popup_menu.dart';

class ResultsCard extends StatefulWidget {
  final EventModel eventModel;
  const ResultsCard({Key? key, required this.eventModel}) : super(key: key);

  @override
  State<ResultsCard> createState() => _ResultsCardState();
}

class _ResultsCardState extends State<ResultsCard> {
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
                                child: ExpandedResultsCard(
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
