import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../functions/position.dart';
import '../../../functions/snackbar.dart';
import '../../../functions/validator.dart';
import '../../../globals/colors.dart';
import '../../../globals/styles.dart';
import '../../../models/spardha_models/spardha_event_model.dart';
import '../../../services/api.dart';
import '../../../stores/result_form_store.dart';
import '../../../widgets/fields/drop_down.dart';
import '../../../widgets/fields/custom_text_field.dart';
import '../../../widgets/cards/card_date_widget.dart';
import '../../../widgets/ui/heading.dart';
import '../../home.dart';

class SpardhaResultForm extends StatefulWidget {
  final SpardhaEventModel event;
  const SpardhaResultForm({super.key, required this.event});

  @override
  State<SpardhaResultForm> createState() => _SpardhaResultFormState();
}

class _SpardhaResultFormState extends State<SpardhaResultForm> {
  TextEditingController victoryStatement = TextEditingController();
  final _linkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _linkController.text = widget.event.link;
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
            backgroundColor: Themes.backgroundColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Themes.backgroundColor,
              shape: const Border(
                bottom: BorderSide(
                  color: Themes.dividerColor1,
                  width: 1,
                ),
              ),
              centerTitle: true,
              title: Text(
                widget.event.results.isEmpty ? 'Add Result' : 'Edit Result',
                style: headline2,
              ),
              leading: IconButton(
                onPressed: () {
                  ResultFormStore.clear();
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Themes.primaryColor,
                ),
                splashColor: Themes.splashColor,
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      if (isLoading) {
                        showSnackBar(context, 'Please wait before trying again');
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await APIService(context).addUpdateSpardhaResult(
                            widget.event.id!,
                            ResultFormStore.resultFields!,
                            ResultFormStore.victoryStatement!,
                            link: _linkController.text.trim(),
                          );
                          if (!mounted) return;

                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(ScoreBoardHome.id, (route) => false);
                          showSnackBar(context, 'Successfully added/updated result');
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
                    style: headline3,
                  ),
                )
              ],
            ),
            body: Form(
              key: key,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: ResultFormStore.numPositions() + 2,
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.event.event,
                                          style: headline1,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          widget.event.category,
                                          style: headline2,
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
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Themes.cardColor,
                                  ),
                                  child: Text(
                                    widget.event.stage,
                                    style: headline3,
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
                          if (index == 1) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: CustomTextField(
                                hintText: 'Score link',
                                validator: validateField,
                                controller: _linkController,
                                isNecessary: false,
                              ),
                            );
                          }
                          index = index - 2;
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              for (int team = 0;
                                  team < ResultFormStore.numTeamsWithPosition(index + 1);
                                  team++)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          getPosition(index),
                                          style: bodyText2,
                                        ),
                                        const Spacer(),
                                        if (team == 0)
                                          GestureDetector(
                                            behavior: HitTestBehavior.translucent,
                                            child: const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Icon(
                                                Icons.add,
                                                color: Themes.primaryColor,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                ResultFormStore.addTeamAtPosition(index + 1);
                                              });
                                            },
                                          ),
                                        if (team != 0)
                                          GestureDetector(
                                            behavior: HitTestBehavior.translucent,
                                            child: const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Icon(
                                                Icons.remove,
                                                color: Themes.errorRed,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                ResultFormStore.removeTeamAtPosition(
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
                                                .resultFields?[index][team].hostelName,
                                            onChanged: (hostel) => ResultFormStore
                                                .resultFields?[index][team].hostelName = hostel,
                                            items: widget.event.hostels.toSet().toList(),
                                            hintText:
                                                'Hostels', // multiple times same hostels can be in list
                                          ),
                                        ),
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
                                                .resultFields?[index][team].primaryScore = ps,
                                            value: ResultFormStore
                                                .resultFields?[index][team].primaryScore,
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
                                                  .resultFields?[index][team].secondaryScore = ss,
                                              value: ResultFormStore
                                                  .resultFields?[index][team].secondaryScore,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: Themes.dividerColor1,
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    if (index + 1 == ResultFormStore.resultFields!.length &&
                                        team + 1 == ResultFormStore.resultFields![index].length)
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              ResultFormStore.addNewPosition(index);
                                            });
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.add,
                                                color: Themes.primaryColor,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Add Position',
                                                style: headline3,
                                              )
                                            ],
                                          ))
                                  ],
                                )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
