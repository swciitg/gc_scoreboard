import 'package:flutter/material.dart';
import '../../../globals/constants.dart';
import '../../../globals/styles.dart';
import '../../../models/spardha_models/spardha_event_model.dart';
import '../../../globals/colors.dart';

class MultipleHostelView extends StatelessWidget {
  final SpardhaEventModel eventModel;

  const MultipleHostelView({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    bool isAllHostel(String category, List<String> participatingHostels) {
      List<String> l1;
      List<String> l2 = [...participatingHostels];

      if (category == eventCategories[0]) {
        l1 = [...menHostel];
      } else if (category == eventCategories[1]) {
        l1 = [...womenHostel];
      } else {
        l1 = [...allHostelList];
      }

      if (l1.length != participatingHostels.length) {
        return false;
      }

      l1.sort((a, b) => a.compareTo(b));
      l2.sort((a, b) => a.compareTo(b));

      for (int i = 0; i < l1.length; i++) {
        if (l1[i] != l2[i]) {
          return false;
        }
      }

      return true;
    }

    final width = (MediaQuery.of(context).size.width - 16) * (0.4);
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 18),
      child: Container(
          // color: Colors.red,
          child: isAllHostel(eventModel.category, eventModel.hostels)
              ? Text(
                  'All hostels will participate.',
                  style: cardVenueStyle2,
                )
              : SizedBox(
                  height: (eventModel.hostels.length).toDouble() * 12,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: eventModel.hostels.length.isEven
                          ? eventModel.hostels.length ~/ 2
                          : (eventModel.hostels.length + 1 / 2).toInt(),
                      itemBuilder: (context, index) {
                        return multipleHostelViewCardItem(index, width);
                      }))),
    );
  }

  Widget multipleHostelViewCardItem(int index, double width) {
    return Row(
      children: [
        Expanded(
            child: SizedBox(
          height: 18,
          child: eventModel.hostels.length >= 2 * index + 1
              ? Row(
                  children: [
                    const Icon(
                      Icons.fiber_manual_record,
                      size: 4,
                      color: Themes.cardFontColor2,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: width,
                      child: Text(
                        eventModel.hostels[2 * index],
                        overflow: TextOverflow.ellipsis,
                        style: cardVenueStyle2,
                      ),
                    )
                  ],
                )
              : Container(),
        )),
        Expanded(
            child: SizedBox(
          height: 18,
          child: eventModel.hostels.length >= 2 * index + 2
              ? Row(
                  children: [
                    const Icon(
                      Icons.fiber_manual_record,
                      size: 4,
                      color: Themes.cardFontColor2,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: width,
                      child: Text(
                        eventModel.hostels[2 * index + 1],
                        overflow: TextOverflow.ellipsis,
                        style: cardVenueStyle2,
                      ),
                    ),
                  ],
                )
              : Container(),
        )),
      ],
    );
  }
}
