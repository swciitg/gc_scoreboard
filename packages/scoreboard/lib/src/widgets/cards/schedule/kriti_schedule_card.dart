import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../../functions/snackbar.dart';
import '../../../globals/colors.dart';
import '../../../globals/constants.dart';
import '../../../globals/enums.dart';
import '../../../globals/styles.dart';
import '../../../models/kriti_models/kriti_event_model.dart';
import '../../../stores/common_store.dart';
import '../card_date_widget.dart';
import '../kriti_clubs_section.dart';
import '../popup_menu.dart';
import '../menu_item.dart';




class KritiScheduleCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final eventModel;
  const KritiScheduleCard({super.key, required this.eventModel});

  @override
  State<KritiScheduleCard> createState() => _KritiScheduleCardState();
}

class _KritiScheduleCardState extends State<KritiScheduleCard> {
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
    bool isKriti = (widget.eventModel.runtimeType == KritiEventModel);

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
                                child: isKriti ? Text(widget.eventModel.cup, style: cardStageStyle1) : Text(widget.eventModel.difficulty, style: cardStageStyle1,),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  isKriti ? Container(
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
                                  ) : Container(),
                                  isKriti ?const SizedBox(width: 8,) : Container(),
                                  GestureDetector(
                                    onTap: () async {
                                      if(!isLinkPressed)
                                        {
                                          setState(() {
                                            isLinkPressed = true;
                                          });
                                          try{
                                            bool validURL = Uri.parse(widget.eventModel.problemLink).isAbsolute; // check if valid url
                                            if(!validURL){
                                              if(isKriti)
                                                {
                                                  await launchUrl(Uri.parse(kritiWebsiteLink),mode: LaunchMode.externalApplication); // if url is not correct

                                                }
                                              else
                                                {
                                                  await launchUrl(Uri.parse(sahyogWebsiteLink),mode: LaunchMode.externalApplication); // if url is not correct
                                                }
                                            }
                                            else{
                                              await launchUrl(Uri.parse(widget.eventModel.problemLink),mode: LaunchMode.externalApplication);
                                            }
                                            setState(() {
                                              isLinkPressed = false;
                                            });
                                          }
                                          catch (err){
                                            if (kDebugMode) {
                                            }
                                            showSnackBar(context, err.toString());
                                            setState(() {
                                              isLinkPressed = false;
                                            });
                                          }
                                        }

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
                                            const SizedBox(width: 3,),
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
                  ]),
                  ClubsListSection(clubs: widget.eventModel.clubs),
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



