import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../functions/snackbar.dart';
import '../../../globals/colors.dart';
import '../../../models/event_model.dart';
import '../../../services/api.dart';
import '../../home.dart';

class ConfirmEventDetails extends StatefulWidget {
  final bool isEdit;
  final EventModel event;
  const ConfirmEventDetails({
    Key? key,
    required this.event,
    required this.isEdit,
  }) : super(key: key);

  @override
  _ConfirmEventDetailsState createState() => _ConfirmEventDetailsState();
}

class _ConfirmEventDetailsState extends State<ConfirmEventDetails> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Themes.theme.backgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Themes.theme.backgroundColor,
            shape: Border(
              bottom: BorderSide(
                color: Themes.theme.dividerColor,
                width: 1,
              ),
            ),
            centerTitle: true,
            title: Text(
              'Confirm Event',
              style: Themes.theme.textTheme.headline2,
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              splashColor: const Color.fromRGBO(118, 172, 255, 0.9),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    if (widget.isEdit) {
                      await APIService(context)
                          .updateSpardhaEvent(widget.event);
                      if (!mounted) return;
                      showSnackBar(context, "Event Edited successfully");
                    } else {
                      await APIService(context)
                          .postEventSchedule(widget.event.toJson());
                      if (!mounted) return;
                      showSnackBar(
                          context, "Event schedule posted successfully");
                    }
                      if (!mounted) return;

                    Navigator.pushNamedAndRemoveUntil(
                        context, ScoreBoardHome.id, (route) => false);
                  } on DioError catch (err) {
                    showErrorSnackBar(context, err);
                  }
                },
                child: Text(
                  'Post',
                  style: Themes.theme.textTheme.headline3,
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Confirm if the following event details are correct.',
                        style: Themes.theme.textTheme.headline4,
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Event Details',
                    style: Themes.theme.textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  DataTile(title: "Sport Name", semiTitle: widget.event.event),
                  const SizedBox(
                    height: 26,
                  ),
                  DataTile(title: "Category", semiTitle: widget.event.category),
                  const SizedBox(
                    height: 26,
                  ),
                  DataTile(title: "Stage", semiTitle: widget.event.stage),
                  const SizedBox(
                    height: 26,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: DataTile(
                                title: "Date",
                                semiTitle: DateFormat('dd-MMM-yyyy')
                                    .format(widget.event.date))),
                        DataTile(
                            title: "Time",
                            semiTitle: widget.event.status == 'postponed'
                                ? "Event postponed"
                                : widget.event.status == 'cancelled'
                                    ? "Event cancelled"
                                    : DateFormat('h:mm a')
                                        .format(widget.event.date))
                      ]),
                  const SizedBox(
                    height: 26,
                  ),
                  DataTile(title: "Venue", semiTitle: widget.event.venue),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Participating Hostels',
                    style: Themes.theme.textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DataTile(
                      title: "Number of Hostels",
                      semiTitle: widget.event.hostels.length.toString()),
                  for (var i = 0; i < widget.event.hostels.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(top: 26),
                      child: DataTile(
                          title: "Hostel Name ${i + 1}",
                          semiTitle: widget.event.hostels[i]),
                    )
                ],
              ),
            ),
          ),
        ));
  }
}

class DataTile extends StatelessWidget {
  final String title;
  final String semiTitle;
  const DataTile({Key? key, required this.title, required this.semiTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Themes.theme.textTheme.bodyText2
              ?.copyWith(color: Themes.bottomNavFontColor),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          semiTitle,
          style: Themes.theme.textTheme.headline6?.copyWith(
              color: semiTitle == 'Event cancelled'
                  ? Themes.errorRed
                  : semiTitle == 'Event postponed'
                      ? Themes.warning
                      : Colors.white),
        )
      ],
    );
  }
}
