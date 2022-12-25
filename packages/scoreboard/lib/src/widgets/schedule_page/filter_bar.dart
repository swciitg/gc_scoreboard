import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../globals/themes.dart';

class FilterBar extends StatefulWidget {
  final List<String> itemsSports;
  final List<String> itemsHostels;
  final TextEditingController hostel;
  final TextEditingController sport;
  const FilterBar({Key? key,
    required this.hostel,
    required this.sport,
    required this.itemsSports,
    required this.itemsHostels, }) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Container(
        height: 56,
        child: Row(
          children: [
            Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Themes.cardColor1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 12,
                                child: Text('Sport',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Themes.cardFontColor1)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 18,
                                child: Text(widget.sport.text,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Themes.cardFontColor2)),
                              )
                            ],
                          ),
                          PopupMenuButton<String>(
                            color: Themes.cardColor1,
                            icon: Icon(
                              Icons.unfold_more_outlined,
                              size: 20,
                              color: Themes.cardFontColor1,
                            ),
                            onSelected: (String item) {
                              setState(() {
                                // selectedSport = item;
                                widget.sport.text = item;
                              });
                            },
                            itemBuilder: (BuildContext context) =>
                                widget.itemsSports.map((item) => PopupMenuItem<String>(
                                  value: item,
                                  child: Text(item,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Themes.cardFontColor2),
                                  ),
                                )
                                ).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Themes.cardColor1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 12,
                                child: Text('Hostel',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Themes.cardFontColor1)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 18,
                                child: Text(widget.hostel.text,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Themes.cardFontColor2)),
                              )
                            ],
                          ),
                          PopupMenuButton<String>(
                            color: Themes.cardColor1,
                            icon: Icon(
                              Icons.unfold_more_outlined,
                              size: 20,
                              color: Themes.cardFontColor1,
                            ),
                            onSelected: (String item) {
                              setState(() {
                                // selectedSport = item;
                                widget.hostel.text = item;
                              });
                            },
                            itemBuilder: (BuildContext context) =>
                                widget.itemsHostels.map((item) => PopupMenuItem<String>(
                                  value: item,
                                  child: Text(item,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: Themes.cardFontColor2),
                                  ),
                                )
                                ).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: Container(
                      alignment: Alignment.center,
                      height: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Themes.cardColor1),
                      child: Icon(
                        Icons.event_outlined,
                        size: 24,
                        color: Themes.primaryColor,
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
