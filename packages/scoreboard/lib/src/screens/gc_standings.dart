import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../globals/styles/filter_style.dart';
import '../globals/colors.dart';
import '../widgets/scoreboard/standingboard.dart';

class GCStandingsPage extends StatefulWidget {
  const GCStandingsPage({super.key});

  @override
  State<GCStandingsPage> createState() => _GCStandingsPageState();
}

class _GCStandingsPageState extends State<GCStandingsPage> {
  late TextEditingController category = TextEditingController(text: 'Men');
  final _itemsCategory = ['Men', 'Women'];

  void onTapped(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Column(
          children: [
            SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                child: Container(
                  height: 56,
                  decoration: boxDecoration,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 12,
                              child: Text('Category', style: popUpHeadingStyle),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 18,
                              child: Text(
                                  'General Championship [${category.text}]',
                                  style: popUpItemStyle),
                            )
                          ],
                        ),
                        PopupMenuButton<String>(
                          color: Themes.cardColor1,
                          icon: popUpIcon,
                          onSelected: (String item) {
                            setState(() {
                              category.text = item;
                            });
                          },
                          itemBuilder: (BuildContext context) => _itemsCategory
                              .map((item) => PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      'General Championship [$item]',
                                      style: popUpItemStyle,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  SvgPicture.asset(
                      "packages/scoreboard/assets/trophy.svg",
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    'GC [${category.text}] Standings',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Themes.kWhite),
                  ),
                ],
              ),
            ),
            
            const SizedBox(
              height: 12,
            ),
            const Divider(
              thickness: 0.7,
              color: Colors.grey,
              height: 0,
              indent: 8,
              endIndent: 8,
            ),
            const Expanded(child: StandingBoard()),
          ],
        ));
  }
}
