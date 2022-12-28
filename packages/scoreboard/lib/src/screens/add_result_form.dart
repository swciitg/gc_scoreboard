import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/models/event_model.dart';
import 'package:scoreboard/src/models/nullable_result_model.dart';
import '../functions/validation.dart';

import '../stores/results_form_store.dart';
import '../globals/themes.dart';
import '../widgets/add_result/custom_text_field.dart';
import '../widgets/add_result/fields_mandatory.dart';
import '../widgets/add_result/hostel_dropdown.dart';

class AddResultForm extends StatelessWidget {
  const AddResultForm({super.key});

  String _positionSuffix(int count) {
    if (count == 1) return 'st';
    if (count == 2) return 'nd';
    if (count == 3) return 'rd';
    return 'th';
  }

  @override
  Widget build(BuildContext context) {
    EventModel event = context.read<ResultsFormStore>().event;
    ResultsFormStore resultStore = context.read<ResultsFormStore>();
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
          event.winners.isEmpty ? 'Add Result' : 'Edit Result',
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
              // List<NullableResultModel> l = resultStore.resultFields ?? [];
              // for (NullableResultModel x in l) {
              //   print(
              //       "Hostel = ${x.hostel}, Points = ${x.points}, PS= ${x.primaryScore}, SS = ${x.secondaryScore}");
              // }
            },
            child: Text(
              'Next',
              style: Themes.theme.textTheme.headline3,
            ),
          )
        ],
      ),
      body: Observer(builder: (context) {
        if (resultStore.resultFields == null) return Container();
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                      SvgPicture.asset('packages/scoreboard/assets/date.svg'),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
              Expanded(
                child: Observer(
                  builder: (_) {
                    return Form(
                      child: ListView.builder(
                        itemCount: resultStore.numResults,
                        itemBuilder: (context, index) {
                          String formKey =
                              "FormField${resultStore.resultFields![index].position}";
                          if (index != 0 &&
                              resultStore.resultFields![index - 1].position ==
                                  resultStore.resultFields![index].position) {
                            formKey += "Tie";
                          }
                          return Column(
                            key: Key(formKey),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${resultStore.resultFields![index].position}${_positionSuffix((resultStore.resultFields![index].position))} Position',
                                    style: Themes.theme.textTheme.bodyText2,
                                  ),
                                  const Spacer(),
                                  if (resultStore.displayAddTieIcon(index))
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.add,
                                          color: Themes.theme.primaryColor,
                                        ),
                                      ),
                                      onTap: () {
                                        resultStore.addTie(resultStore
                                            .resultFields![index].position);
                                      },
                                    ),
                                  if (resultStore.displayRemoveTieIcon(index))
                                    // if (countOf(_counter.l, _counter.l[index]) == 2 &&
                                    //     index != 0 &&
                                    //     _counter.l[index] == _counter.l[index - 1])
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.remove,
                                          color: Themes.theme.errorColor,
                                        ),
                                      ),
                                      onTap: () {
                                        resultStore.removePosition(index);
                                      },
                                    ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 65,
                                    child: HostelDropDown(
                                      value: resultStore
                                          .resultFields?[index].hostel,
                                      onChanged: (hostel) => resultStore
                                          .resultFields?[index].hostel = hostel,
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 5,
                                  ),
                                  Expanded(
                                      flex: 30,
                                      child: CustomTextField(
                                        isNecessary: true,
                                        hintText: 'Points',
                                        validator: validateScore,
                                        onChanged: (p) => resultStore
                                            .resultFields?[index]
                                            .points = int.tryParse(p),
                                        value: resultStore
                                            .resultFields?[index].points
                                            .toString(),
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 46,
                                    child: CustomTextField(
                                      isNecessary: true,
                                      hintText: 'Primary Score',
                                      validator: validateScore,
                                      onChanged: (ps) => resultStore
                                          .resultFields?[index]
                                          .primaryScore = ps,
                                      value: resultStore
                                          .resultFields?[index].primaryScore,
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 6,
                                  ),
                                  Expanded(
                                      flex: 46,
                                      child: CustomTextField(
                                        isNecessary: false,
                                        hintText: 'Secondary Score',
                                        validator: null,
                                        onChanged: (ss) => resultStore
                                            .resultFields?[index]
                                            .secondaryScore = ss,
                                        value: resultStore.resultFields?[index]
                                            .secondaryScore,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Divider(
                                thickness: 1,
                                color: Themes.theme.dividerColor,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              if (resultStore.displayAddPosition(index))
                                TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {
                                      resultStore.addNewPosition(resultStore
                                          .resultFields?[index].position);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Themes.theme.primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Add Position',
                                          style:
                                              Themes.theme.textTheme.headline3,
                                        )
                                      ],
                                    ))
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
