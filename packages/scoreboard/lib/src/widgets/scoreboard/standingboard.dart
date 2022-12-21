import 'package:flutter/material.dart';
import '../../globals/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class StandingBoard extends StatefulWidget {
  const StandingBoard({
    Key? key,
  })  : super(key: key);


  @override
  State<StandingBoard> createState() => _StandingBoardState();
}

class _StandingBoardState extends State<StandingBoard> {
  var _list = [0, 1, 2];
  var _images = [
    'packages/scoreboard/assets/images_standingboard/GoldMedal.png',
    'packages/scoreboard/assets/images_standingboard/SilverMedal.png',
    'packages/scoreboard/assets/images_standingboard/BronzeMedal.png',
    'https://cdn.dribbble.com/users/465625/screenshots/16421846/media/5e93cae5c3e0bd0eeb5c21a29f3dce64.png?compress=1&resize=400x300'
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 0),
      child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18), color: Themes.cardColor),
          child: ListView.separated(
            itemCount: 10+1,    //give length of content + 1 for heading  
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('Position',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Themes.cardFontColor2)),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Text('Hostels',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Themes.cardFontColor2)),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Expanded(
                        flex: 1,
                        child: Text('Score',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Themes.cardFontColor2)),
                      ),
                    )
                  ],
                ),
              );
              }
              index -= 1;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16,vertical: 0),
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
                                fontSize: 12,
                                color: Themes.cardFontColor2)),
                          SizedBox(width: 5,),
                          index==1 || index==0 || index==2? Image(image: AssetImage(_images[index].toString(),)):Text(''),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Image.network(
                            _images[3].toString(),
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text('name',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Themes.cardFontColor2)),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Expanded(
                        flex: 1,
                        child: Text('age',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Themes.cardFontColor2)),
                      ),
                    )
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
          )),
    ));
  }
}
