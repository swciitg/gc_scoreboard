import 'package:flutter/material.dart';
import '../../globals/colors.dart';

class EventFormHeading extends StatelessWidget {
  const EventFormHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: FieldsMandatory(),
        ),
        Text(
          'Event Details',
          style: Themes.theme.textTheme.headline1,
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

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
