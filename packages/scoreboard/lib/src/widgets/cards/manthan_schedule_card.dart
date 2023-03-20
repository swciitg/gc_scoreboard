import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../globals/styles.dart';
import '../../models/manthan_models/manthan_event_model.dart';
import '../../stores/common_store.dart';
import 'card_date_widget.dart';
import 'popup_menu.dart';
import 'menu_item.dart';



class ManthanScheduleCard extends StatefulWidget {
  final eventModel;
  const ManthanScheduleCard({super.key, required this.eventModel});

  @override
  State<ManthanScheduleCard> createState() => _ManthanScheduleCardState();
}

class _ManthanScheduleCardState extends State<ManthanScheduleCard> {
  bool isLinkPressed = false;

  List<PopupMenuEntry> popupOptions = [
    optionsMenuItem('Edit', 'edit schedule', Themes.kWhite),
    const PopupMenuDivider(
      height: 2,
    ),
    optionsMenuItem('Add result', 'add', Themes.primaryColor),
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
        child: PopupMenu(
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
                      height: 78,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: SizedBox(
                                  height: 28,
                                  child: Text(widget.eventModel.event, style: cardEventStyle),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child:
                                isManthan
                                    ? Text(widget.eventModel.module, style: cardStageStyle1)
                                    : Text(''),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.access_time_outlined,
                              color: Themes.cardFontColor2,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(DateFormat.jm().format(widget.eventModel.date),
                                style: cardTimeStyle)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Themes.cardFontColor2,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                widget.eventModel.venue,
                                overflow: TextOverflow.ellipsis,
                                style: cardVenueStyle1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}



