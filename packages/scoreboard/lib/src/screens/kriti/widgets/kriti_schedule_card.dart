import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/widgets/cards/popup_menu.dart';
import '../../../globals/colors.dart';
import '../../../globals/enums.dart';
import '../../../globals/styles.dart';
import '../../../models/kriti_models/kriti_event_model.dart';
import '../../../stores/common_store.dart';
import '../../../widgets/cards/card_date_widget.dart';
import '../../../widgets/cards/menu_item.dart';
import 'popup_menu.dart';



class KritiScheduleCard extends StatefulWidget {
  final KritiEventModel eventModel;
  const KritiScheduleCard({super.key, required this.eventModel});

  @override
  State<KritiScheduleCard> createState() => _KritiScheduleCardState();
}

class _KritiScheduleCardState extends State<KritiScheduleCard> {

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
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: KritiPopupMenu(
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
                      height: 98,
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
                                child: Text(widget.eventModel.cup, style: cardStageStyle1),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 26,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Themes.kGrey,
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      child: Text(widget.eventModel.difficulty,
                                          style:
                                          cardCategoryStyle
                                          ),
                                    ),
                                  ),
                                  SizedBox(width: 8,),
                                  GestureDetector(
                                    onTap: (){

                                    },
                                    child: Container(
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFFC907),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child:  Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Center(
                                              child: Icon(Icons.launch_outlined,color: Colors.black,size: 15,),
                                            ),
                                            SizedBox(width: 3,),
                                            Text(
                                              'Open Problem',
                                              style:  GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
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
                    const SizedBox(
                      height: 32,
                    )
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


