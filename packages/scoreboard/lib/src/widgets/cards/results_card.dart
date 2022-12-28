import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scoreboard/src/widgets/cards/popup_menu.dart';

import '../../widgets/cards/expanded_results_card.dart';
import '../../models/event_model.dart';

import '../../globals/themes.dart';
import 'menu_item.dart';

class ResultsCard extends StatefulWidget {
  final EventModel eventModel;
  final bool isTie;
  ResultsCard({Key? key, required this.eventModel, required this.isTie})
      : super(key: key);

  @override
  State<ResultsCard> createState() => _ResultsCardState();
}

class _ResultsCardState extends State<ResultsCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 186),
        child: PopupMenu(
          items: [
            OptionsMenuItem('Edit', 'edit result', Themes.kWhite),
            PopupMenuDivider(
              height: 2,
            ),
            OptionsMenuItem('Delete', 'delete', Themes.errorRed),
          ],
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Themes.cardColor2),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 98,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Container(
                                  height: 28,
                                  child: Text(
                                    widget.eventModel.event,
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
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 34, 8, 0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 28,
                                    width: 66,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 24,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.emoji_events_outlined,
                                  color: Themes.cardFontColor3,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  widget.isTie
                                      ? 'Tie - ${widget.eventModel.hostels[0]} & ${widget.eventModel.hostels[1]}'
                                      : '${widget.eventModel.hostels[0]} won',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Themes.cardFontColor3),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Container(
                              height: 24,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Themes.kGrey),
                              width: 64,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                child: Row(
                                  children: [
                                    Text(
                                      isExpanded ? 'Less' : 'More',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: Themes.cardFontColor2),
                                    ),
                                    Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_up_outlined
                                          : Icons.keyboard_arrow_down_outlined,
                                      size: 14,
                                      color: Themes.cardFontColor2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  isExpanded
                      ? Column(
                          children: [
                            Divider(
                              height: 32,
                              color: Themes.bottomNavHighlightColor,
                              thickness: 1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                height: 12,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 26,
                                          ),
                                          Text(
                                            'Hostel',
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10,
                                                color:
                                                    Themes.bottomNavFontColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Score',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: Themes.bottomNavFontColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 2),
                              child: ExpandedResultsCard(
                                  eventModel: widget.eventModel),
                            )
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
