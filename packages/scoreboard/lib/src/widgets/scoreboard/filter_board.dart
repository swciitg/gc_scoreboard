import 'package:flutter/material.dart';
import '../../globals/themes.dart';
import 'package:google_fonts/google_fonts.dart';

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
          height: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18), color: Themes.cardColor),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                isExpanded: true,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Themes.cardFontColor2),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 23,
                  color: Themes.cardFontColor1,
                ),
                dropdownColor: Themes.cardColor,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  fillColor: Colors.transparent,
                  labelText: widget.heading,
                  labelStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Themes.cardFontColor1),
                ),
              ),
            ),
          )),
    ));
  }
}
