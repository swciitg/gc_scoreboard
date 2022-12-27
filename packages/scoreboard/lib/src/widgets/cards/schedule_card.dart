import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scoreboard/src/widgets/cards/menu_item.dart';
import '../../widgets/cards/popup_menu.dart';
import '../../screens/add_event_form.dart';
import '../../screens/add_result_form.dart';
import '../../widgets/cards/athletics_schedule_card.dart';
import '../../models/event_model.dart';
import '../../globals/themes.dart';

class ScheduleCard extends StatefulWidget {
  final EventModel eventModel;
  final String status;
  ScheduleCard({super.key, required this.eventModel, required this.status});

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
            OptionsMenuItem('Add result', 'add', Themes.primaryColor),
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
                  Container(
                    height: 98,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Container(
                                height: 28,
                                child: Text(
                                  widget.eventModel.name,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Themes.cardFontColor2),
                                ),
                              ),
                            ),
                            Container(
                              height: 20,
                              child: Text(
                                widget.eventModel.category,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Themes.bottomNavFontColor),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              height: 26,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromRGBO(71, 71, 71, 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  widget.eventModel.stage,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Themes.cardFontColor3),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          width: 82,
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                'assets/date.svg',
                                package: 'scoreboard',
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 34, 8, 0),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 28,
                                  width: 66,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat.d()
                                            .format(widget.eventModel.date),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Themes.cardFontColor2),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        DateFormat.LLL()
                                            .format(widget.eventModel.date),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Themes.cardFontColor2),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  widget.eventModel.hostels.length > 2
                      ? AthleticsScheduleCard(eventModel: widget.eventModel)
                      : Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 18,
                                      width: 18,
                                      child: SvgPicture.asset(
                                        'assets/kriti2.svg',
                                        package: 'scoreboard',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
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
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 18,
                                      width: 18,
                                      child: SvgPicture.asset(
                                        'assets/manthan2.svg',
                                        package: 'scoreboard',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
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
                        ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 18,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.access_time_outlined,
                                color: Themes.cardFontColor2,
                                size: 14,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              if (widget.status == 'postponed')
                                Text('Event postponed',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Themes.cardFontColor3))
                              else if (widget.status == 'cancelled')
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
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 18,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Themes.cardFontColor2,
                                size: 14,
                              ),
                              SizedBox(
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
