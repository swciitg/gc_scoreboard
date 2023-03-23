import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../globals/styles.dart';
import '../../stores/common_store.dart';
import '../../stores/spardha_store.dart';
import '../../stores/static_store.dart';
import '../fields/datepicker_color.dart';
import 'filter_button.dart';

class SpardhaFilterBar extends StatefulWidget {
  const SpardhaFilterBar({Key? key}) : super(key: key);

  @override
  State<SpardhaFilterBar> createState() => _SpardhaFilterBarState();
}

class _SpardhaFilterBarState extends State<SpardhaFilterBar> {
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
                      ? FilterButton(
                          label: 'Category',
                          value: spardhaStore.selectedCategory.categoryName,
                          items: itemsCategory,
                          setFunction: (String value) {
                            spardhaStore.changeSelectedCategory(value);
                          })
                      : Container(),
                  FilterButton(
                      label: 'Event',
                      value: spardhaStore.selectedEvent,
                      items: itemsEvents,
                      setFunction: (String value) {
                        spardhaStore.changeSelectedEvent(value);
                      }),
                  commonStore.page != Pages.standings
                      ? FilterButton(
                          label: 'Hostel',
                          value: spardhaStore.selectedHostel.hostelName,
                          items: itemsHostels,
                          setFunction: (String value) {
                            spardhaStore.changeSelectedHostel(value);
                          })
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
                                  lastDate: DateTime(2101),
                                  builder: (context, child) => DatePickerTheme(
                                        child: child,
                                      ));
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
                        Text("Showing for ", style: bottomNavStyle2),
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
                                  style: cardStageStyle2),
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
