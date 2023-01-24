import 'package:flutter/material.dart';
import 'package:scoreboard/src/models/kriti_models/kriti_event_model.dart';

class ConfirmKritiEventDetails extends StatefulWidget {
  final bool isEdit;
  final KritiEventModel event;
  const ConfirmKritiEventDetails({Key? key, required this.isEdit, required this.event}) : super(key: key);

  @override
  State<ConfirmKritiEventDetails> createState() => _ConfirmKritiEventDetailsState();
}

class _ConfirmKritiEventDetailsState extends State<ConfirmKritiEventDetails> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
