import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../globals/styles.dart';
import '../../models/manthan_models/manthan_event_model.dart';
import '../../stores/common_store.dart';
import 'card_date_widget.dart';
import 'manthan_popup_menu.dart';
import 'menu_item.dart';

class ManthanResultCard extends StatefulWidget {
  final eventModel;
  const ManthanResultCard({super.key, required this.eventModel});

  @override
  State<ManthanResultCard> createState() => _ManthanResultCardState();
}

class _ManthanResultCardState extends State<ManthanResultCard> {
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
    bool isManthan = (widget.eventModel.runtimeType == ManthanEventModel);
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ManthanPopupMenu(
          eventModel: widget.eventModel,
          items: commonStore.viewType == ViewType.admin ? popupOptions : [],
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Themes.cardColor2,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    SizedBox(
                      height: isManthan ? 98 : 78,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: SizedBox(
                                  height: 28,
                                  child: Text(widget.eventModel.event,
                                      style: cardEventStyle),
                                ),
                              ),
                              isManthan
                                  ? SizedBox(
                                      height: 20,
                                      child: Text(widget.eventModel.module,
                                          style: cardStageStyle1))
                                  : Container(),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                          Container(
                              alignment: Alignment.topCenter,
                              width: 82,
                              child: DateWidget(
                                date: widget.eventModel.date,
                              ))
                        ],
                      ),
                    ),
                  ]),
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
                        SizedBox(
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
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: SizedBox(
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
                                      'Points',
                                      style: cardResultStyle2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            HostelsPointsSection(eventModel: widget.eventModel)
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class HostelsPointsSection extends StatelessWidget {
  final ManthanEventModel eventModel;

  const HostelsPointsSection({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: eventModel.results.length * 30,
        ),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: eventModel.results.length,
            itemBuilder: (context, index) {
              final split =
                  eventModel.results[index].secondaryScore?.split(',');
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 18,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 16,
                            height: 18,
                            child: Text(
                              '${index + 1}',
                              style: cardVenueStyle1,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 210,
                            child: Text(
                              overflow: TextOverflow.visible,
                              eventModel.results[index].hostelName!,
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
                          Container(
                            width: 40,
                            child: Text(
                              eventModel.results[index].primaryScore!
                                  .toString(),
                              style: cardPostponedStyle,
                            ),
                          ),
                          eventModel.results[index].secondaryScore == null
                              ? Container()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    SizedBox(
                                      width: (split?.length.toDouble())! * 40,
                                      child: ListView.builder(
                                          itemCount: split?.length,
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              alignment: Alignment.centerRight,
                                              width: 40,
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
            }));
  }
}
