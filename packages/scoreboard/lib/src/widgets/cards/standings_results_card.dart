import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoreboard/src/models/standing_model.dart';
import 'package:scoreboard/src/widgets/cards/standings_expanded_results_card.dart';
import 'package:scoreboard/src/widgets/cards/standing_popup_menu.dart';
import '../../globals/styles/card_style.dart';
import '../../globals/colors.dart';
import 'menu_item.dart';

class StandingsResultCard extends StatefulWidget {
  final StandingModel standingModel;
  const StandingsResultCard({Key? key, required this.standingModel})
      : super(key: key);

  @override
  State<StandingsResultCard> createState() => _StandingsResultCardState();
}

class _StandingsResultCardState extends State<StandingsResultCard> {
  List<PopupMenuEntry> popupOptions = [
    OptionsMenuItem('Edit', 'edit standings', Themes.kWhite),
    const PopupMenuDivider(
      height: 2,
    ),
    OptionsMenuItem('Delete', 'delete', Themes.errorRed),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 50),
          child: StandingPopup(
            items: popupOptions,
            standingModel: widget.standingModel,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Themes.cardColor2),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Column(children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              child: SizedBox(
                                height: 28,
                                child: Text(widget.standingModel.event,
                                    style: cardEventStyle),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: Text(widget.standingModel.category,
                                  style: cardCategoryStyle),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(
                      //   height: 32,
                      // )
                    ]),
                    Column(
                      children: [
                        const Divider(
                          height: 32,
                          color: Themes.bottomNavHighlightColor,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 26,
                                  ),
                                  Text(
                                    'Hostel',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Themes.bottomNavFontColor),
                                  ),
                                ],
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: StandingsExpandedresultsCard(
                              standingModel: widget.standingModel),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
