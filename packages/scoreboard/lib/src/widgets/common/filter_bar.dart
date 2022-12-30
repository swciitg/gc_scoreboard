import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/decorations/filter_style.dart';
import 'package:scoreboard/src/globals/helper_variables.dart';
import 'package:scoreboard/src/stores/common_store.dart';
import 'package:scoreboard/src/stores/user_store.dart';
import '../../globals/themes.dart';
import 'package:intl/intl.dart';

class FilterBar extends StatefulWidget {
  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();

    List<String> itemsEvents = ['Overall'];
    List<String> itemsHostels =[];
    List<String> itemsCategory = [];

    if(commonStore.competition == Competitions.spardha){
      itemsEvents.addAll(UserStore.spardhaEvents);
      itemsHostels = Hostel.values.map((e) => e.hostelName).toList(); // get all hostel names from common store hostel
      itemsCategory = Category.values.map((e) => e.categoryName).toList(); // get all categories from common store category
    }

    return Observer(
      builder: (context) {
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
                            position: PopupMenuPosition.under,
                            color: Themes.cardColor1,
                            onSelected: (String item) {
                              commonStore.changeSelectedCategory(item);
                            },
                            itemBuilder: (BuildContext context) =>
                                itemsCategory.map((item) => PopupMenuItem<String>(
                                  value: item,
                                  child: Text(item,
                                    style: popUpItemStyle,
                                  ),
                                )
                                ).toList(),
                            child: Container(
                              height: 56,
                              decoration: boxDecoration,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                          child: Text(commonStore.selectedCategory.categoryName,
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
                        )
                    )
                    : Container(),

                    Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                          child: PopupMenuButton(
                            position: PopupMenuPosition.under,
                            color: Themes.cardColor1,
                            onSelected: (String item) {
                              commonStore.changeSelectedEvent(item);
                            },
                            itemBuilder: (BuildContext context) =>
                                itemsEvents.map((item) => PopupMenuItem<String>(
                                  value: item,
                                  child: Text(item,
                                    style: popUpItemStyle,
                                  ),
                                )
                                ).toList(),
                            child: Container(
                              height: 56,
                              decoration: boxDecoration,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                          child: Text(commonStore.selectedEvent,
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
                            FocusScope.of(context)
                                .requestFocus(FocusNode());
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
                              position: PopupMenuPosition.under,
                              color: Themes.cardColor1,
                              onSelected: (String item) {
                                print(item);
                                commonStore.changeSelectedHostel(item);
                                print(commonStore.selectedHostel.hostelName);
                              },
                              itemBuilder: (BuildContext context) =>
                                  itemsHostels.map((item) => PopupMenuItem<String>(
                                    value: item,
                                    child: Text(item,
                                      style: popUpItemStyle,
                                    ),
                                  )
                                  ).toList(),
                              child: Container(
                                height: 56,
                                decoration: boxDecoration,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                                commonStore.selectedHostel.hostelName,
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
                        )
                    )
                    : Container(),

                    commonStore.page != Pages.standings
                    ? Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            FocusScope.of(context)
                                .requestFocus(FocusNode());
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              if (!mounted) return;
                              commonStore.changeSelectedDate(pickedDate.toIso8601String());
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
                        )
                    )
                    : Container(),
                  ],
                ),
                Visibility(
                  visible: commonStore.selectedDate.isNotEmpty ? true : false, // date selected or not
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12,top: 12),
                    child: Row(
                      children: [
                        Text("Showing for ",style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Themes.bottomNavFontColor)),
                        Container(
                          margin: EdgeInsets.only(left: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Themes.primaryColor,
                                  width: 1.5
                              ),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(commonStore.selectedDate.isNotEmpty ? DateFormat('dd-MMM-yyyy')
                                  .format(DateTime.parse(commonStore.selectedDate)) : '', style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Themes.secondaryColor)),
                              SizedBox(
                                height: 16,
                                width: 20,
                                child: IconButton(
                                  alignment: Alignment.topLeft,
                                  padding: const  EdgeInsets.only(left: 4),
                                  onPressed: (){
                                    commonStore.changeSelectedDate(''); // making selected date empty
                                  },
                                  icon: const Icon(Icons.clear,color: Themes.secondaryColor),
                                  iconSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
