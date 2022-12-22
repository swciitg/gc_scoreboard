import 'package:flutter/material.dart';

void showSnackBar(BuildContext buildContext,String message){
  ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(content: Text(message)));
}