import 'package:flutter/material.dart';
import 'package:scoreboard/src/globals/colors.dart';

class FieldsMandatory extends StatelessWidget {
  const FieldsMandatory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Fields marked with',
            style: Themes.theme.textTheme.headline4,
          ),
          TextSpan(
            text: ' * ',
            style: Themes.theme.textTheme.headline5,
          ),
          TextSpan(
            text: 'are compulsory',
            style: Themes.theme.textTheme.headline4,
          ),
        ],
      ),
    );
  }
}