import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBar(BuildContext buildContext, String message) {
  ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
    content: Text(
      message,
      style: GoogleFonts.montserrat(),
    ),
    duration: const Duration(seconds: 5),
  ));
}

void showErrorSnackBar(BuildContext buildContext, DioError err) {
  ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
    content: Text(
      (err.response != null && err.response!.statusCode! == 406)
          ? err.response!.data['message']
          : "Some error occurred. try again",
      style: GoogleFonts.montserrat(),
    ),
    duration: const Duration(seconds: 5),
  ));
}