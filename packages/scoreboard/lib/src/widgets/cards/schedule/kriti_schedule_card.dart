import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:onestop_ui/index.dart';
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
import '../menu_item.dart';
import '../popup_menu.dart';

class KritiScheduleCard extends StatefulWidget {
  final dynamic eventModel;

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
              borderRadius: BorderRadius.circular(OCornerRadius.l),
              color: OColor.white,
              border: Border.all(color: OColor.gray200, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: SizedBox(
                                  height: 28,
                                  child: Text(widget.eventModel.event,
                                      style: cardEventStyle, overflow: TextOverflow.ellipsis, maxLines: 1),
                                ),
                              ),
                            SizedBox(
                              height: 20,
                              child: isKriti
                                  ? Text(widget.eventModel.cup,
                                      style: cardStageStyle1)
                                  : Text(
                                      widget.eventModel.difficulty,
                                      style: cardStageStyle1,
                                    ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                isKriti
                                    ? Container(
                                        height: 26,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Themes.primaryColor.withValues(alpha: 0.1),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          child: Text(
                                              widget.eventModel.difficulty,
                                              style: cardCategoryStyle),
                                        ),
                                      )
                                    : Container(),
                                isKriti
                                    ? const SizedBox(
                                        width: 8,
                                      )
                                    : Container(),
                                GestureDetector(
                                  onTap: () async {
                                    if (!isLinkPressed) {
                                      setState(() {
                                        isLinkPressed = true;
                                      });
                                      try {
                                        bool validURL = Uri.parse(
                                                widget.eventModel.problemLink)
                                            .isAbsolute; // check if valid url
                                        if (!validURL) {
                                          if (isKriti) {
                                            await launchUrl(
                                                Uri.parse(kritiWebsiteLink),
                                                mode: LaunchMode
                                                    .externalApplication); // if url is not correct
                                          } else {
                                            await launchUrl(
                                                Uri.parse(sahyogWebsiteLink),
                                                mode: LaunchMode
                                                    .externalApplication); // if url is not correct
                                          }
                                        } else {
                                          await launchUrl(
                                              Uri.parse(widget
                                                  .eventModel.problemLink),
                                              mode: LaunchMode
                                                  .externalApplication);
                                        }
                                        setState(() {
                                          isLinkPressed = false;
                                        });
                                      } catch (err) {
                                        if (!context.mounted) return;
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
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Themes.primaryColor, width: 1),
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Center(
                                            child: Icon(
                                              Icons.launch_outlined,
                                              color: Themes.primaryColor,
                                              size: 15,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            'Open Problem',
                                            style: TextStyle(
                                              fontFamily: 'Geist',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Themes.primaryColor,
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
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (widget.eventModel.link.isNotEmpty)
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    bool validURL =
                                        Uri.parse(widget.eventModel.link)
                                            .isAbsolute; // check if valid url
                                    if (!validURL) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Some error occurred. Try again!",
                                            style: basicFontStyle,
                                          ),
                                          duration: Duration(seconds: 5),
                                        ),
                                      );
                                    } else {
                                      await launchUrl(
                                          Uri.parse(widget.eventModel.link),
                                          mode: LaunchMode.externalApplication);
                                    }
                                  } catch (err) {
                                    if (!context.mounted) return;
                                    showSnackBar(context, err.toString());
                                  }
                                },
                                child: Text("View Score",
                                    style: cardCategoryStyle),
                              ),
                            if (widget.eventModel.link.isNotEmpty)
                              const SizedBox(height: 8),
                            Container(
                                alignment: Alignment.topCenter,
                                width: 82,
                                child: DateWidget(
                                  date: widget.eventModel.date,
                                )),
                          ],
                        )
                      ],
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
                            Icon(
                              Icons.access_time_outlined,
                              color: OColor.gray500,
                              size: 16,
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
                            Icon(
                              Icons.location_on_outlined,
                              color: OColor.gray500,
                              size: 16,
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
