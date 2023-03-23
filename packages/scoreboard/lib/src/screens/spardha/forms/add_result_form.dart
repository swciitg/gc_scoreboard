import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../functions/position.dart';
import '../../../functions/snackbar.dart';
import '../../../functions/validator.dart';
import '../../../globals/colors.dart';
import '../../../models/spardha_models/spardha_event_model.dart';
import '../../../services/api.dart';
import '../../../stores/result_form_store.dart';
import '../../../widgets/fields/drop_down.dart';
import '../../../widgets/fields/custom_text_field.dart';
import '../../../widgets/cards/card_date_widget.dart';
import '../../../widgets/ui/heading.dart';
import '../../home.dart';

class SpardhaResultForm extends StatefulWidget {
  final EventModel event;
  const SpardhaResultForm({super.key, required this.event});

  @override
  State<SpardhaResultForm> createState() => _SpardhaResultFormState();
}

class _SpardhaResultFormState extends State<SpardhaResultForm> {
  TextEditingController victoryStatement = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.event.results.isNotEmpty) {
      ResultFormStore.resultFields = widget.event.results;
      ResultFormStore.victoryStatement = widget.event.victoryStatement!;
    }
  }

  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
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
                widget.event.results.isEmpty ? 'Add Result' : 'Edit Result',
                style: Themes.theme.textTheme.headline2,
              ),
              leading: IconButton(
                onPressed: () {
                  ResultFormStore.clear();
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  color: Themes.theme.primaryColor,
                ),
                splashColor: Themes.splashColor,
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      if (isLoading) {
                        showSnackBar(
                            context, 'Please wait before trying again');
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await APIService(context).addUpdateSpardhaResult(
                              widget.event.id!,
                              ResultFormStore.resultFields!,
                              ResultFormStore.victoryStatement!);
                          if (!mounted) return;

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              ScoreBoardHome.id, (route) => false);
                          showSnackBar(
                              context, 'Successfully added/updated result');
                          ResultFormStore.clear();
                          if (!mounted) return;

                          Navigator.pushNamedAndRemoveUntil(
                              context, ScoreBoardHome.id, (route) => false);
                        } on DioError catch (err) {
                          showErrorSnackBar(context, err);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                  child: Text(
                    'Next',
                    style: Themes.theme.textTheme.headline3,
                  ),
                )
              ],
            ),
            body: Form(
              key: key,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: ResultFormStore.numPositions() + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const FieldsMandatory(),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.event.event,
                                          style:
                                              Themes.theme.textTheme.headline1,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          widget.event.category,
                                          style:
                                              Themes.theme.textTheme.headline2,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    DateWidget(
                                      date: widget.event.date,
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
                                    widget.event.stage,
                                    style: Themes.theme.textTheme.headline3,
                                  ),
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                CustomTextField(
                                  inputType: TextInputType.text,
                                  hintText: 'Victory Statement',
                                  validator: validateField,
                                  value: ResultFormStore.victoryStatement,
                                  onChanged: (p) {
                                    ResultFormStore.victoryStatement = p;
                                  },
                                  isNecessary: true,
                                ),
                              ],
                            );
                          }
                          index--;
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              for (int team = 0;
                                  team <
                                      ResultFormStore.numTeamsWithPosition(
                                          index + 1);
                                  team++)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          getPosition(index),
                                          style:
                                              Themes.theme.textTheme.bodyText2,
                                        ),
                                        const Spacer(),
                                        if (team == 0)
                                          GestureDetector(
                                            behavior:
                                                HitTestBehavior.translucent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Icon(
                                                Icons.add,
                                                color:
                                                    Themes.theme.primaryColor,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                ResultFormStore
                                                    .addTeamAtPosition(
                                                        index + 1);
                                              });
                                            },
                                          ),
                                        if (team != 0)
                                          GestureDetector(
                                            behavior:
                                                HitTestBehavior.translucent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Icon(
                                                Icons.remove,
                                                color: Themes.theme.errorColor,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                ResultFormStore
                                                    .removeTeamAtPosition(
                                                        index + 1, team);
                                              });
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
                                          child: CustomDropDown(
                                            validator: validateField,
                                            value: ResultFormStore
                                                .resultFields?[index][team]
                                                .hostelName,
                                            onChanged: (hostel) =>
                                                ResultFormStore
                                                    .resultFields?[index][team]
                                                    .hostelName = hostel,
                                            items: widget.event.hostels.toSet().toList(), hintText: 'Hostels', // multiple times same hostels can be in list
                                          ),
                                        ),
                                        // const Spacer(
                                        //   flex: 5,
                                        // ),
                                        // Expanded(
                                        //     flex: 30,
                                        //     child: CustomTextField(
                                        //       isNecessary: true,
                                        //       hintText: 'Points',
                                        //       validator: validateField,
                                        //       onChanged: (p) => ResultFormStore
                                        //           .resultFields?[index][team]
                                        //           .points = int.tryParse(p),
                                        //       value: ResultFormStore
                                        //           .resultFields?[index][team].points
                                        //           .toString(),
                                        //     ))
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
                                            inputType: TextInputType.text,
                                            isNecessary: true,
                                            hintText: 'Primary Score',
                                            validator: validateField,
                                            onChanged: (ps) => ResultFormStore
                                                .resultFields?[index][team]
                                                .primaryScore = ps,
                                            value: ResultFormStore
                                                .resultFields?[index][team]
                                                .primaryScore,
                                          ),
                                        ),
                                        const Spacer(
                                          flex: 6,
                                        ),
                                        Expanded(
                                            flex: 46,
                                            child: CustomTextField(
                                              inputType: TextInputType.text,
                                              isNecessary: false,
                                              hintText: 'Secondary Score',
                                              validator: null,
                                              onChanged: (ss) => ResultFormStore
                                                  .resultFields?[index][team]
                                                  .secondaryScore = ss,
                                              value: ResultFormStore
                                                  .resultFields?[index][team]
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
                                    if (index + 1 ==
                                            ResultFormStore
                                                .resultFields!.length &&
                                        team + 1 ==
                                            ResultFormStore
                                                .resultFields![index].length)
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              ResultFormStore.addNewPosition(
                                                  index);
                                            });
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                color:
                                                    Themes.theme.primaryColor,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Add Position',
                                                style: Themes
                                                    .theme.textTheme.headline3,
                                              )
                                            ],
                                          ))
                                  ],
                                )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
