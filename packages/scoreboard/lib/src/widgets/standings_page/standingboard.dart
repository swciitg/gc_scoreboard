import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../globals/constants.dart';


class StandingBoard extends StatefulWidget {
  List<dynamic> hostelStandings;
  StandingBoard({
    Key? key, required this.hostelStandings
  }) : super(key: key);

  @override
  State<StandingBoard> createState() => _StandingBoardState();
}

class _StandingBoardState extends State<StandingBoard> {
  final _colorMedal = [
    0xffFFC907,
    0xffD0DBDD,
    0xffF07E48,
  ];


  @override
  Widget build(BuildContext context) {
    print(widget.hostelStandings);
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),color: Themes.cardColor1),
      child: widget.hostelStandings.isEmpty ? Center(
        child: Text("No Standings found",
            softWrap: true,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Themes.kWhite)),
      ) : ListView.separated(
        itemCount: widget.hostelStandings.length + 1, //give length of content + 1 for heading
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Position',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: Themes.cardFontColor2)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Hostels',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Themes.cardFontColor2)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text('Points',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Themes.cardFontColor2)),
                    ),
                  ),
                ],
              ),
            );
          }
          index -= 1;
          print(widget.hostelStandings[index]["hostelName"]);
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text('${index + 1}',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Themes.cardFontColor2)),
                      const SizedBox(
                        width: 5,
                      ),
                      index == 1 || index == 0 || index == 2
                          ? Icon(
                              Icons.workspace_premium,
                              color: Color(_colorMedal[index]),
                              size: 18,
                            )
                          : const Text(''),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Image.asset(
                          hostelsImagePath[widget.hostelStandings[index]["hostelName"]]!,
                          // 'packages/scoreboard/assets/logos/subansiri.jpg',
                          height: 30,
                          width: 30,
                          cacheHeight: 50,
                          cacheWidth: 50,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                              widget.hostelStandings[index]["hostelName"],
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Themes.cardFontColor2)),
                        ),
                      ],
                    ),
                    // alignment: Alignment.centerLeft,
                    // child: Text(widget.hostelStandings[index]["hostelName"],
                    //     style: GoogleFonts.montserrat(
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: 13,
                    //         color: Themes.cardFontColor2)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(widget.hostelStandings[index]["points"].toString(),
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Themes.cardFontColor2)),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 0.7,
            color: Color.fromRGBO(94, 94, 94, 0.38),
            indent: 20,
            endIndent: 20,
            height: 0,
          );
        },
      ),
    );
  }
}
