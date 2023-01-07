import 'package:flutter/material.dart';
import 'package:scoreboard/src/globals/constants.dart';
import '../../globals/colors.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final String _imageUrl =
      'https://cdn.dribbble.com/users/465625/screenshots/16421846/media/5e93cae5c3e0bd0eeb5c21a29f3dce64.png?compress=1&resize=400x300';

  @override
  Widget build(BuildContext context) {
    print(widget.hostelStandings);
    return Container(
      margin: EdgeInsets.fromLTRB(4, 16, 4, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18), color: Themes.cardColor1),
      child: widget.hostelStandings.length==0 ? Center(
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
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
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
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
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
                          : Text(''),
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
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(widget.hostelStandings[index]["hostelName"],
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Themes.cardFontColor2)),
                      ],
                    ),
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
            color: Colors.grey,
            indent: 20,
            endIndent: 20,
            height: 0,
          );
        },
      ),
    );
  }
}
