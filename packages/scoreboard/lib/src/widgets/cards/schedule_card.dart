import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/globals/enums.dart';
import 'package:scoreboard/src/stores/common_store.dart';
import 'package:scoreboard/src/widgets/cards/time_venue_widget.dart';
import '../../widgets/cards/popup_menu.dart';
import '../../widgets/cards/athletics_schedule_card.dart';
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
    return Observer(
      builder: (context) {
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
                          ? AthleticsScheduleCard(eventModel: widget.eventModel)
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: SvgPicture.asset(
                                        'assets/kriti2.svg',
                                        package: 'scoreboard',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      widget.eventModel.hostels[0],
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Themes.cardFontColor2),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                height: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: SvgPicture.asset(
                                        'assets/manthan2.svg',
                                        package: 'scoreboard',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      widget.eventModel.hostels[1],
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Themes.cardFontColor2),
                                    )
                                  ],
                                ),
                              ),
                            ],
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
      }
    );
  }
}
