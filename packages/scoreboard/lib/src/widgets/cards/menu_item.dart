import 'package:flutter/material.dart';

PopupMenuEntry optionsMenuItem(String label, String value, Color color) {
  return PopupMenuItem(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 42,
      value: value,
      child: Center(
        child: Text(label,
            style: TextStyle(
              fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500, fontSize: 12, color: color)),
      ));
}
