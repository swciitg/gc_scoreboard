import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:scoreboard/src/stores/kriti_store.dart';

import '../../../globals/colors.dart';
import '../../../globals/enums.dart';
import '../../../globals/styles.dart';
import '../../../stores/common_store.dart';
import '../../../stores/spardha_store.dart';
import '../../../stores/static_store.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({Key? key}) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    var kritiStore = context.read<KritiStore>();

    List<String> itemsEvents = ['Overall'];
    List<String> items = [];
    List<String> itemsCategory = [];

    if (commonStore.competition == Competitions.spardha) {
      itemsEvents.addAll(StaticStore.spardhaEvents);
      itemsHostels = Hostel.values
          .map((e) => e.hostelName)
          .toList(); // get all hostel names from common store hostel
      itemsCategory = Category.values
          .map((e) => e.categoryName)
          .toList(); // get all categories from common store category
    }

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
                                spardhaStore.changeSelectedCategory(item);
                              },
                              itemBuilder: (BuildContext context) =>
                                  itemsCategory
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
                                            child: Text('Category',
                                                style: popUpHeadingStyle),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          SizedBox(
                                            height: 18,
                                            child: Text(
                                                spardhaStore.selectedCategory
                                                    .categoryName,
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
                  Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: PopupMenuButton(
                          constraints: const BoxConstraints(maxHeight: 300),
                          position: PopupMenuPosition.under,
                          color: Themes.cardColor1,
                          onSelected: (String item) {
                            spardhaStore.changeSelectedEvent(item);
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
                                        child: Text('Event',
                                            style: popUpHeadingStyle),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 18,
                                        child: Text(spardhaStore.selectedEvent,
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
                      )),
                ],
              ),
            ]),
          ));
    });
  }
}
