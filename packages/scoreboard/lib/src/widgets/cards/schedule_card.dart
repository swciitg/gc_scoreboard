import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../widgets/cards/popup_menu.dart';
import '../../widgets/cards/athletics_schedule_card.dart';
import '../../models/event_model.dart';
import '../../globals/themes.dart';
import 'card_event_details.dart';
import 'menu_item.dart';

class ScheduleCard extends StatefulWidget {
  final EventModel eventModel;
  const ScheduleCard({super.key, required this.eventModel});

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: widget.eventModel.hostels.length == 11 ? 256 : 290),
        child: PopupMenu(
          items: [
            OptionsMenuItem('Edit', 'edit schedule', Themes.kWhite),
            const PopupMenuDivider(
              height: 2,
            ),
            OptionsMenuItem('Add result', 'add', Themes.primaryColor),
            const PopupMenuDivider(
              height: 2,
            ),
            OptionsMenuItem('Delete', 'delete', Themes.errorRed),
          ],
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
                            if (widget.eventModel.status == 'postponed')
                              Text('Event postponed',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Themes.cardFontColor3))
                            else if (widget.eventModel.status == 'cancelled')
                              Text('Event cancelled',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Themes.cardFontColor4))
                            else
                              Text(
                                  DateFormat.jm()
                                      .format(widget.eventModel.date),
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Themes.cardFontColor2))
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
                            Text(
                              widget.eventModel.venue,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Themes.cardFontColor2),
                            )
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
      ),
    );
  }
}
