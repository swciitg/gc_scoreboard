import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../globals/enums.dart';
import '../../stores/common_store.dart';
import '../../stores/manthan_store.dart';
import '../../stores/static_store.dart';
import 'filter_button.dart';

class ManthanFilterBar extends StatefulWidget {
  const ManthanFilterBar({super.key});

  @override
  State<ManthanFilterBar> createState() => _ManthanFilterBarState();
}

class _ManthanFilterBarState extends State<ManthanFilterBar> {
  List<String> moduleNames = Module.values.map((e) => e.moduleName).toList();

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    var manthanStore = context.read<ManthanStore>();

    List<String> itemsEvents = ['Overall'];

    itemsEvents.addAll(StaticStore.manthanEvents);

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
                      value: manthanStore.selectedEvent,
                      items: itemsEvents,
                      setFunction: (String value) {
                        manthanStore.changeSelectedEvent(value);
                      })
                      : Container(),
                  commonStore.page != Pages.standings
                      ? FilterButton(
                    label: 'Module',
                    value: manthanStore.selectedModule,
                    items: moduleNames,
                    setFunction: (String value) {
                      manthanStore.changeSelectedModule(value);
                    },
                  )
                      : Container(),
                ],
              ),
            ]),
          ));
    });
  }
}
