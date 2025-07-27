import 'package:flutter/material.dart';
import 'package:scoreboard/src/globals/styles.dart';

class EventFormHeading extends StatelessWidget {
  const EventFormHeading({super.key});

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
          style: headline1,
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Fields marked with',
            style: headline4,
          ),
          TextSpan(
            text: ' * ',
            style: headline5,
          ),
          TextSpan(
            text: 'are compulsory',
            style: headline4,
          ),
        ],
      ),
    );
  }
}
