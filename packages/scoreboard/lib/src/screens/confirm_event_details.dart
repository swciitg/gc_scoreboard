import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoreboard/src/globals/themes.dart';
import 'package:scoreboard/src/models/event_model.dart';
import 'package:scoreboard/src/models/result_model.dart';

class ConfirmEventDetails extends StatefulWidget {
  final EventModel? event;
  final bool isPostponed;
  final bool isCancelled;
  const ConfirmEventDetails(
      {Key? key,
      required this.event,
      required this.isPostponed,
      required this.isCancelled})
      : super(key: key);

  @override
  _ConfirmEventDetailsState createState() => _ConfirmEventDetailsState();
}

class _ConfirmEventDetailsState extends State<ConfirmEventDetails> {
  //<------- TEST -------->
  List<ResultModel> results = [];
  List<String> hostels = ["Brahmaputra", "Kameng", "Manas", "Dihing"];
  //<------- TEST -------->

  @override
  Widget build(BuildContext context) {
    //<------- TEST -------->
    EventModel test = EventModel(
        name: "500m Sprint",
        group: "Athletics",
        category: "Men",
        stage: "Semi-Final",
        date: DateTime(12 - 03 - 2002),
        venue: "Athletics Track",
        results: results,
        hostels: hostels);
    //<------- TEST -------->
    return Scaffold(
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
            onPressed: () {},
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
              DataTile(title: "Sport Name", semiTitle: test.name),
              const SizedBox(
                height: 26,
              ),
              DataTile(title: "Sport Group", semiTitle: test.category),
              const SizedBox(
                height: 26,
              ),
              DataTile(title: "Category", semiTitle: test.category),
              const SizedBox(
                height: 26,
              ),
              DataTile(title: "Stage", semiTitle: test.stage),
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
                            semiTitle:
                                DateFormat('dd-MMM-yyyy').format(test.date))),
                    DataTile(
                        title: "Time",
                        semiTitle: widget.isPostponed
                            ? "Event postponed"
                            : widget.isCancelled
                                ? "Event cancelled"
                                : DateFormat('h:mm a').format(test.date))
                  ]),
              const SizedBox(
                height: 26,
              ),
              DataTile(title: "Venue", semiTitle: test.venue),
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
                  semiTitle: test.hostels.length.toString()),
              for (var i = 0; i < test.hostels.length; i++)
                Padding(
                  padding: const EdgeInsets.only(top: 26),
                  child: DataTile(
                      title: "Hostel Name ${i + 1}",
                      semiTitle: test.hostels[i]),
                )
            ],
          ),
        ),
      ),
    );
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
