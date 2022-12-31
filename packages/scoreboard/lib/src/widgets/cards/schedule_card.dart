import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/globals/enums.dart';
import 'package:scoreboard/src/stores/common_store.dart';
import 'package:scoreboard/src/widgets/cards/schedule/single_hostel_view.dart';
import 'package:scoreboard/src/widgets/cards/schedule/time_venue_widget.dart';
import '../../widgets/cards/popup_menu.dart';
import 'schedule/multiple_hostel_view.dart';
import '../../models/event_model.dart';
import '../../globals/colors.dart';
import 'card_event_details.dart';
import 'menu_item.dart';

class ScheduleCard extends StatefulWidget {
  final EventModel eventModel;
  const ScheduleCard({super.key, required this.eventModel});

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  List<PopupMenuEntry> popupOptions = [
    OptionsMenuItem('Edit', 'edit schedule', Themes.kWhite),
    const PopupMenuDivider(
      height: 2,
    ),
    OptionsMenuItem('Add result', 'add', Themes.primaryColor),
    const PopupMenuDivider(
      height: 2,
    ),
    OptionsMenuItem('Delete', 'delete', Themes.errorRed),
  ];
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: widget.eventModel.hostels.length == 11 ? 256 : 290),
          child: PopupMenu(
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
                    CardEventDetails(eventModel: widget.eventModel),
                    widget.eventModel.hostels.length > 2
                        ? MultipleHostelView(eventModel: widget.eventModel)
                        : BiHostelView(
                            hostelA: widget.eventModel.hostels[0],
                            hostelB: widget.eventModel.hostels[1],
                          ),
                    const SizedBox(
                      height: 32,
                    ),
                    TimeVenueWidget(eventModel: widget.eventModel),
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
