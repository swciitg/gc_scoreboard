import 'package:flutter/material.dart';
import '../../globals/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FilterList extends StatefulWidget {
  final String heading;
  final List<String> items;
  final String index;
  final Function callbackFunction;
  const FilterList(
      {super.key,
      required this.heading,
      required this.items,
      required this.callbackFunction,
      required this.index});

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: Container(
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18), color: Themes.cardColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                value: widget.index,
                items: widget.items
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    widget.callbackFunction(val as String);
                  });
                },
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Themes.cardFontColor2),
                icon: Icon(
                      FontAwesomeIcons.angleDown,
                      size: 13,
                      color: Themes.cardFontColor1,
                    ),
                dropdownColor: Themes.cardColor,
                decoration: InputDecoration(
                  labelText: widget.heading,
                  labelStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Themes.cardFontColor1),
                ),
              ),
            ),
          )),
    ));
  }
}
