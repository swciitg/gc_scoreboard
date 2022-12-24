import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/event_model.dart';
import '../../globals/themes.dart';

class AthleticsScheduleCard extends StatelessWidget {
  final EventModel eventModel;
  const AthleticsScheduleCard({Key? key, required this.eventModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 18),
      child: Container(
          // color: Colors.red,
          child: eventModel.hostels.length > 12
              ? Container(
                  child: Text(
                    'All hostels will participate.',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Themes.cardFontColor2),
                  ),
                )
              : Container(
                  height: (eventModel.hostels.length).toDouble() * 12,
                  child: ListView.builder(
                      itemCount: eventModel.hostels.length.isEven
                          ? (eventModel.hostels.length / 2).toInt()
                          : (eventModel.hostels.length + 1 / 2).toInt(),
                      itemBuilder: (context, index) {
                        return AthleticsScheduleCardItem(index);
                      }))),
    );
  }

  Widget AthleticsScheduleCardItem(int index) {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 18,
          child: eventModel.hostels.length >= 2 * index + 1
              ? Row(
                  children: [
                    Icon(
                      Icons.fiber_manual_record,
                      size: 4,
                      color: Themes.cardFontColor2,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      eventModel.hostels[2 * index],
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Themes.cardFontColor2),
                    ),
                  ],
                )
              : Container(),
        )),
        Expanded(
            child: Container(
          height: 18,
          child: eventModel.hostels.length >= 2 * index + 2
              ? Row(
                  children: [
                    Icon(
                      Icons.fiber_manual_record,
                      size: 4,
                      color: Themes.cardFontColor2,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      eventModel.hostels[2 * index + 1],
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Themes.cardFontColor2),
                    ),
                  ],
                )
              : Container(),
        )),
      ],
    );
  }
}
