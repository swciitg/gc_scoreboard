import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../globals/colors.dart';

class BiHostelView extends StatelessWidget {
  final String hostelA;
  final String hostelB;
  const BiHostelView({Key? key, required this.hostelA, required this.hostelB}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
                width: 18,
                child: SvgPicture.asset(
                  'assets/kriti2.svg',
                  package: 'scoreboard',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                hostelA,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Themes.cardFontColor2),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
                width: 18,
                child: SvgPicture.asset(
                  'assets/manthan2.svg',
                  package: 'scoreboard',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                hostelB,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Themes.cardFontColor2),
              )
            ],
          ),
        ),
      ],
    );
  }
}
