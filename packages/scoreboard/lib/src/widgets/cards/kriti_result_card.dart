import 'package:flutter/material.dart';
import 'package:scoreboard/src/models/kriti_models/kriti_event_model.dart';

class KritiResultCard extends StatefulWidget {
  final KritiEventModel eventModel;
  const KritiResultCard({Key? key, required this.eventModel}) : super(key: key);

  @override
  State<KritiResultCard> createState() => _KritiResultCardState();
}

class _KritiResultCardState extends State<KritiResultCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
        child: Center(
          child: Text(widget.eventModel.victoryStatement!),
        ),
    );
  }
}
