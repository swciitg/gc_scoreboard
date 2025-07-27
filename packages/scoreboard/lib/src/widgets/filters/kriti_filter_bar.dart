import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../globals/enums.dart';
import '../../stores/common_store.dart';
import '../../stores/kriti_store.dart';
import '../../stores/static_store.dart';
import 'filter_button.dart';

class KritiFilterBar extends StatefulWidget {
  const KritiFilterBar({super.key});

  @override
  State<KritiFilterBar> createState() => _KritiFilterBarState();
}

class _KritiFilterBarState extends State<KritiFilterBar> {
  List<String> cupNames = Cup.values.map((e) => e.cupName).toList();
  List<String> clubNames = Club.values.map((e) => e.clubName).toList();
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    var kritiStore = context.read<KritiStore>();

    List<String> itemsEvents = ['Overall'];

    itemsEvents.addAll(StaticStore.kritiEvents);

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
                          value: kritiStore.selectedEvent,
                          items: itemsEvents,
                          setFunction: (String value) {
                            kritiStore.changeSelectedEvent(value);
                          })
                      : Container(),
                  commonStore.page != Pages.standings
                      ? FilterButton(
                          label: 'Cup',
                          value: kritiStore.selectedCup.cupName,
                          items: cupNames,
                          setFunction: (String value) {
                            kritiStore.changeSelectedCup(value);
                          },
                        )
                      : Container(),
                  commonStore.page != Pages.standings
                      ? FilterButton(
                          label: 'Club',
                          value: kritiStore.selectedClub.clubName,
                          items: clubNames,
                          setFunction: (String value) {
                            kritiStore.changeSelectedClub(value);
                          })
                      : Container(),
                ],
              ),
            ]),
          ));
    });
  }
}
