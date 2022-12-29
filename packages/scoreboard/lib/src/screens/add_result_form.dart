import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scoreboard/src/globals/auth_user_helper.dart';
import 'package:scoreboard/src/models/event_model.dart';
import 'package:scoreboard/src/models/nullable_result_model.dart';
import 'package:scoreboard/src/models/result_model.dart';
import 'package:scoreboard/src/stores/result_form_store.dart';
import 'package:scoreboard/src/widgets/add_result/list_view_widget.dart';

import '../globals/themes.dart';

import '../widgets/add_result/fields_mandatory.dart';

class AddResultForm extends StatelessWidget {

   AddResultForm({super.key});

  final EventModel event  = EventModel(event: 'Cricket', category: 'Men', stage: 'Stage', date: DateTime.now(), venue: 'IITG', hostels: ['Kameng','Brahma'], status: 'Finished', results: [ResultModel(position: 1, hostel: 'kameng', points: 89, primaryScore: '82/21')], resultAdded: false);

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        backgroundColor: Themes.theme.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Themes.theme.backgroundColor,
          shape: Border(
            bottom: BorderSide(
              color: Themes.theme.dividerColor,
              width: 1,
            ),
          ),
          centerTitle: true,
          title: Text(
            event.results.isEmpty ? 'Add Result' : 'Edit Result',
            style: Themes.theme.textTheme.headline2,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Themes.theme.primaryColor,
            ),
            splashColor: const Color.fromRGBO(118, 172, 255, 0.9),
          ),
          actions: [
            TextButton(
              onPressed: () {
                List<NullableResultModel> l = ResultForm.resultFields ?? [];
                for (NullableResultModel x in l) {
                  print(
                      "${x.position}: Hostel = ${x.hostel}, Points = ${x.points}, PS= ${x.primaryScore}, SS = ${x.secondaryScore}");
                }
              },
              child: Text(
                'Next',
                style: Themes.theme.textTheme.headline3,
              ),
            )
          ],
        ),
        body: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FieldsMandatory(),
                    const SizedBox(
                      height: 28,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.event,
                              style: Themes.theme.textTheme.headline1,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              event.category,
                              style: Themes.theme.textTheme.headline2,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Stack(
                          alignment: const Alignment(0, 0.5),
                          children: [
                            SvgPicture.asset(
                                'packages/scoreboard/assets/date.svg'),
                            Text(
                              '18 Feb',
                              style: Themes.theme.textTheme.headline1,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Themes.theme.cardColor,
                      ),
                      child: Text(
                        event.stage,
                        style: Themes.theme.textTheme.headline3,
                      ),
                    ),
                    const SizedBox(
                      height: 37,
                    ),
                    AddResultList()
                  ],
                ),
              ));
  }
}
