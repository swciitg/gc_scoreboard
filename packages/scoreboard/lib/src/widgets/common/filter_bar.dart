import 'package:flutter/material.dart';
import 'package:scoreboard/src/decorations/filter_style.dart';
import '../../globals/themes.dart';

class FilterBar extends StatefulWidget {
  final String screen;
  final TextEditingController hostel;
  final TextEditingController sport;
  final TextEditingController category;
  const FilterBar({Key? key,
    required this.hostel,
    required this.sport,
    required this.category,
    required this.screen,  }) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {

  final List<String> _itemsSports = [
    'Overall',
    'Athletics',
    'Swimming',
    'Basketball',
    'Football',
    'Badminton',
    'Aquatics'
  ];

  final List<String> _itemsHostels =[
    'Overall',
    'Brahma',
    'Manas',
    'Kameng',
  ];

  final List<String> _itemsCategory = ['Overall', 'Men', 'Women'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            widget.screen == 'standings'
            ? Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: PopupMenuButton(
                    position: PopupMenuPosition.under,
                    color: Themes.cardColor1,
                    onSelected: (String item) {
                      setState(() {
                        widget.category.text = item;
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        _itemsCategory.map((item) => PopupMenuItem<String>(
                          value: item,
                          child: Text(item,
                            style: popUpItemStyle,
                          ),
                        )
                        ).toList(),
                    child: Container(
                      height: 56,
                      decoration: boxDecoration,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 12,
                                  child: Text('Category',
                                      style: popUpHeadingStyle),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 18,
                                  child: Text(widget.category.text,
                                      style: popUpItemStyle),
                                )
                              ],
                            ),
                            popUpIcon,
                          ],
                        ),
                      ),
                    ),
                  ),
                )
            )
            : Container(),

            Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: PopupMenuButton(
                    position: PopupMenuPosition.under,
                    color: Themes.cardColor1,
                    onSelected: (String item) {
                      setState(() {
                        widget.sport.text = item;
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        _itemsSports.map((item) => PopupMenuItem<String>(
                          value: item,
                          child: Text(item,
                            style: popUpItemStyle,
                          ),
                        )
                        ).toList(),
                    child: Container(
                      height: 56,
                      decoration: boxDecoration,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 12,
                                  child: Text('Sport',
                                      style: popUpHeadingStyle),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 18,
                                  child: Text(widget.sport.text,
                                      style: popUpItemStyle),
                                )
                              ],
                            ),
                            popUpIcon,
                          ],
                        ),
                      ),
                    ),
                  ),
                )),

            widget.screen != 'standings'
                ? Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: PopupMenuButton(
                    position: PopupMenuPosition.under,
                    color: Themes.cardColor1,
                    onSelected: (String item) {
                      setState(() {
                        widget.hostel.text = item;
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        _itemsHostels.map((item) => PopupMenuItem<String>(
                          value: item,
                          child: Text(item,
                            style: popUpItemStyle,
                          ),
                        )
                        ).toList(),
                    child: Container(
                      height: 56,
                      decoration: boxDecoration,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 12,
                                  child: Text('Hostel',
                                      style: popUpHeadingStyle),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 18,
                                  child: Text(widget.hostel.text,
                                      style: popUpItemStyle),
                                )
                              ],
                            ),
                            popUpIcon,
                          ],
                        ),
                      ),
                    ),
                  ),
                )
            )
            : Container(),

            widget.screen != 'standings'
            ? Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: Container(
                      alignment: Alignment.center,
                      height: 56,
                      decoration: boxDecoration,
                      child: const Icon(
                        Icons.event_outlined,
                        size: 24,
                        color: Themes.primaryColor,
                      )),
                )
            )
            : Container(),
          ],
        ),
      ),
    );
  }
}
