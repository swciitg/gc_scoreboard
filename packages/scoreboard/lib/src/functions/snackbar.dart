import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
void showSnackBar(BuildContext buildContext,String message){
  ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(content: Text(message,style: GoogleFonts.montserrat(),)));
}