import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../globals/styles.dart';
import '../../../models/spardha_models/spardha_event_model.dart';
import '../../../globals/colors.dart';

class TimeVenueWidget extends StatelessWidget {
  final SpardhaEventModel eventModel;

  const TimeVenueWidget({Key? key, required this.eventModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.access_time_outlined,
                color: Themes.cardFontColor2,
                size: 14,
              ),
              const SizedBox(
                width: 8,
              ),
              if (eventModel.status == 'postponed')
                Text('Event postponed', style: cardPostponedStyle)
              else if (eventModel.status == 'cancelled')
                Text('Event cancelled', style: cardCancelledStyle)
              else
                Text(DateFormat.jm().format(eventModel.date),
                    style: cardTimeStyle)
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Themes.cardFontColor2,
                size: 14,
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: 200,
                child: Text(
                  eventModel.venue,
                  overflow: TextOverflow.ellipsis,
                  style: cardVenueStyle1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
