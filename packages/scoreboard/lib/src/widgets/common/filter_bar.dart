import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';
import 'package:intl/intl.dart';

import '../../globals/enums.dart';
import '../../globals/styles/filter_style.dart';
import '../../stores/common_store.dart';
import '../../stores/spardha_store.dart';
import '../../stores/static_store.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({Key? key}) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    var spardhaStore = context.read<SpardhaStore>();

    List<String> itemsEvents = ['Overall'];
    List<String> itemsHostels = [];
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  commonStore.page == Pages.standings
                      ? Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                            child: PopupMenuButton(
                              constraints: BoxConstraints(maxHeight: 300),
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
                          constraints: BoxConstraints(maxHeight: 300),
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
                  commonStore.page != Pages.standings
                      ? Flexible(
                          flex: 3,
                          child: GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                if (!mounted) return;
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                              child: PopupMenuButton(
                                constraints: BoxConstraints(maxHeight: 300),
                                position: PopupMenuPosition.under,
                                color: Themes.cardColor1,
                                onSelected: (String item) {
                                  spardhaStore.changeSelectedHostel(item);
                                },
                                itemBuilder: (BuildContext context) =>
                                    itemsHostels
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
                                              child: Text('Hostel',
                                                  style: popUpHeadingStyle),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                              height: 18,
                                              child: Text(
                                                  spardhaStore.selectedHostel
                                                      .hostelName,
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
                            ),
                          ))
                      : Container(),
                  commonStore.page != Pages.standings
                      ? Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                if (!mounted) return;
                                spardhaStore.changeSelectedDate(
                                    pickedDate.toIso8601String());
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 56,
                                  decoration: boxDecoration,
                                  child: const Icon(
                                    Icons.event_outlined,
                                    size: 24,
                                    color: Themes.primaryColor,
                                  )),
                            ),
                          ))
                      : Container(),
                ],
              ),
              Visibility(
                  visible: spardhaStore.selectedDate.isNotEmpty
                      ? true
                      : false, // date selected or not
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, top: 12),
                    child: Row(
                      children: [
                        Text("Showing for ",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Themes.bottomNavFontColor)),
                        Container(
                          margin: const EdgeInsets.only(left: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Themes.primaryColor, width: 1.5),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  spardhaStore.selectedDate.isNotEmpty
                                      ? DateFormat('dd-MMM-yyyy').format(
                                          DateTime.parse(
                                              spardhaStore.selectedDate))
                                      : '',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Themes.primaryColor)),
                              SizedBox(
                                height: 16,
                                width: 20,
                                child: IconButton(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.only(left: 4),
                                  onPressed: () {
                                    spardhaStore.changeSelectedDate(
                                        ''); // making selected date empty
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Themes.primaryColor),
                                  iconSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      );
    });
  }
}
