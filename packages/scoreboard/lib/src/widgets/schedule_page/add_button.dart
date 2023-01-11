import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddButton extends StatelessWidget {
  final String text;
  final double? width;

  const AddButton({Key? key, required this.text, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0xffFFC907),
          borderRadius: BorderRadius.circular(21),
        ),
        height: 40,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.add,
              size: 20,
            ),
            Text(
              text,
              style: GoogleFonts.montserrat(
                  fontSize: 15, fontWeight: FontWeight.w600),
            )
          ],
        ));
  }
}
