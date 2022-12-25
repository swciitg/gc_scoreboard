import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../globals/themes.dart';

class FilterStandings extends StatefulWidget {
  final List<String> itemsSports;
  final List<String> itemsCategory;
  final TextEditingController category;
  final TextEditingController sport;
  const FilterStandings({Key? key,
    required this.category,
    required this.sport,
    required this.itemsSports,
    required this.itemsCategory, }) : super(key: key);

  @override
  State<FilterStandings> createState() => _FilterStandingsState();
}

class _FilterStandingsState extends State<FilterStandings> {

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
                                child: Text('Category',
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
                                child: Text(widget.category.text,
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
                                widget.category.text = item;
                              });
                            },
                            itemBuilder: (BuildContext context) =>
                                widget.itemsCategory.map((item) => PopupMenuItem<String>(
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
          ],
        ),
      ),
    );
  }
}
