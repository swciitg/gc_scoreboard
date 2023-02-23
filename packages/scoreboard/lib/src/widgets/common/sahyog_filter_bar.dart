import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/stores/kriti_store.dart';

import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../globals/styles.dart';
import '../../stores/common_store.dart';
import '../../stores/sahyog_store.dart';
import '../../stores/static_store.dart';

class SahyogFilterBar extends StatefulWidget {
  const SahyogFilterBar({Key? key}) : super(key: key);

  @override
  State<SahyogFilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<SahyogFilterBar> {
  List<String> diff = ['Overall','High Prep', "Mid Prep", 'Low Prep'];
  List<String> clubNames = Club.values.map((e) => e.clubName).toList();
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    var sahyogStore = context.read<SahyogStore>();

    List<String> itemsEvents = ['Overall'];

    itemsEvents.addAll(StaticStore.sahyogEvents);

    return Observer(builder: (context) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 99),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                children: [
                  commonStore.page == Pages.standings
                      ? Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: PopupMenuButton(
                          constraints: const BoxConstraints(maxHeight: 300),
                          position: PopupMenuPosition.under,
                          color: Themes.cardColor1,
                          onSelected: (String item) {
                            sahyogStore.changeSelectedEvent(item);
                          },
                          itemBuilder: (BuildContext context) => itemsEvents
                              .map((item) => PopupMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: popUpItemStyle,
                            ),
                          ))
                              .toList(),
                          child: Container(
                            height: 56,
                            decoration: boxDecoration,
                            child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(13, 0, 13, 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 12,
                                        child: Text('Event',
                                            style: popUpHeadingStyle),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 18,
                                        child: Text(
                                            sahyogStore.selectedEvent,
                                            style: popUpItemStyle),
                                      )
                                    ],
                                  ),
                                  popUpIcon,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                      : Container(),
                  commonStore.page != Pages.standings ? Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: PopupMenuButton(
                          constraints: const BoxConstraints(maxHeight: 300),
                          position: PopupMenuPosition.under,
                          color: Themes.cardColor1,
                          onSelected: (String item) {
                            sahyogStore.changeDifficulty(item);
                          },
                          itemBuilder: (BuildContext context) => diff
                              .map((item) => PopupMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: popUpItemStyle,
                            ),
                          ))
                              .toList(),
                          child: Container(
                            height: 56,
                            decoration: boxDecoration,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 12,
                                        child: Text('Difficulty',
                                            style: popUpHeadingStyle),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 18,
                                        child: Text(
                                            sahyogStore.difficulty,
                                            style: popUpItemStyle),
                                      )
                                    ],
                                  ),
                                  popUpIcon,
                                ],
                              ),
                            ),
                          ),
                        ),
                      )) : Container(),
                  commonStore.page != Pages.standings ? Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: PopupMenuButton(
                          constraints: const BoxConstraints(maxHeight: 300),
                          position: PopupMenuPosition.under,
                          color: Themes.cardColor1,
                          onSelected: (String item) {
                            sahyogStore.changeSelectedClub(item);
                          },
                          itemBuilder: (BuildContext context) =>
                              clubNames.map((item) => PopupMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: popUpItemStyle,
                                ),
                              ))
                                  .toList(),
                          child: Container(
                            height: 56,
                            decoration: boxDecoration,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 12,
                                        child: Text('Club',
                                            style: popUpHeadingStyle),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 18,
                                        child: Text(
                                            sahyogStore.selectedClub.clubName,
                                            style: popUpItemStyle),
                                      )
                                    ],
                                  ),
                                  popUpIcon,
                                ],
                              ),
                            ),
                          ),
                        ),
                      )) : Container(),
                ],
              ),
            ]),
          ));
    });
  }
}
