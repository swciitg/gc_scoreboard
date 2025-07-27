import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../globals/enums.dart';
import '../../stores/common_store.dart';
import '../../stores/sahyog_store.dart';
import '../../stores/static_store.dart';
import 'filter_button.dart';

class SahyogFilterBar extends StatefulWidget {
  const SahyogFilterBar({super.key});

  @override
  State<SahyogFilterBar> createState() => _SahyogFilterBarState();
}

class _SahyogFilterBarState extends State<SahyogFilterBar> {
  List<String> diff = ['Overall', 'High', "Mid", 'Low'];
  List<String> clubNames = SahyogClub.values.map((e) => e.clubName).toList();
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
                      ? FilterButton(
                          label: 'Event',
                          value: sahyogStore.selectedEvent,
                          items: itemsEvents,
                          setFunction: (String value) {
                            sahyogStore.changeSelectedEvent(value);
                          })
                      : Container(),
                  commonStore.page != Pages.standings
                      ? FilterButton(
                          label: 'Difficulty',
                          value: sahyogStore.difficulty,
                          items: diff,
                          setFunction: (String value) {
                            sahyogStore.changeDifficulty(value);
                          })
                      : Container(),
                  commonStore.page != Pages.standings
                      ? FilterButton(
                          label: 'Club',
                          value: sahyogStore.selectedClub.clubName,
                          items: clubNames,
                          setFunction: (String value) {
                            sahyogStore.changeSelectedClub(value);
                          })
                      : Container(),
                ],
              ),
            ]),
          ));
    });
  }
}
