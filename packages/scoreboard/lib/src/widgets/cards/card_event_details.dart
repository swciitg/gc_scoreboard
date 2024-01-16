import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';
import '../../models/spardha_models/spardha_event_model.dart';
import 'card_date_widget.dart';

class CardEventDetails extends StatelessWidget {
  final SpardhaEventModel eventModel;
  const CardEventDetails({Key? key, required this.eventModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: SizedBox(
                    height: 28,
                    child: Text(eventModel.event, style: cardEventStyle),
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: Text(eventModel.category, style: cardCategoryStyle),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Themes.kGrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(eventModel.stage,
                        style: eventModel.results.isEmpty ? cardStageStyle1 : cardStageStyle2),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (eventModel.link.isNotEmpty)
                  GestureDetector(
                      onTap: () async {
                        var url = eventModel.link;
                        if (!eventModel.link.startsWith('http://') &&
                            !eventModel.link.startsWith('https://')) {
                          url = 'http://$url';
                        }
                        if (await canLaunchUrlString(url)) {
                          await launchUrlString(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Some error occurred. try again",
                                style: basicFontStyle,
                              ),
                              duration: Duration(seconds: 5),
                            ),
                          );
                        }
                      },
                      child: const Text("view score", style: cardCategoryStyle)),
                if (eventModel.link.isNotEmpty) const SizedBox(height: 8),
                Container(
                  alignment: Alignment.topCenter,
                  width: 82,
                  child: DateWidget(
                    date: eventModel.date,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      const SizedBox(
        height: 32,
      )
    ]);
  }
}
