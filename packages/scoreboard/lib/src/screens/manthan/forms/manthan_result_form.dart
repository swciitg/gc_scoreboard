import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../functions/position.dart';
import '../../../functions/snackbar.dart';
import '../../../functions/validator.dart';
import '../../../globals/colors.dart';
import '../../../globals/constants.dart';
import '../../../globals/styles.dart';
import '../../../models/manthan_models/manthan_event_model.dart';
import '../../../services/api.dart';
import '../../../widgets/fields/drop_down.dart';
import '../../../widgets/fields/custom_text_field.dart';
import '../../../widgets/cards/card_date_widget.dart';
import '../../../widgets/ui/heading.dart';
import '../../home.dart';
import 'manthan_result_store.dart';

class ManthanResultForm extends StatefulWidget {
  final ManthanEventModel event;

  const ManthanResultForm({super.key, required this.event});

  @override
  State<ManthanResultForm> createState() => _ManthanResultFormState();
}

class _ManthanResultFormState extends State<ManthanResultForm> {
  TextEditingController victoryStatement = TextEditingController();
  final _linkController = TextEditingController();

  @override
  void initState() {
    _linkController.text = widget.event.link;
    super.initState();
    if (widget.event.results.isNotEmpty) {
      ManthanResultFormStore.resultFields = widget.event.results;
      ManthanResultFormStore.victoryStatement = widget.event.victoryStatement!;
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
                  ManthanResultFormStore.clear();
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
                          await APIService(context).addUpdateResult(
                            eventID: widget.event.id!,
                            data: ManthanResultFormStore.resultFields!,
                            victoryStatement: ManthanResultFormStore.victoryStatement!,
                            competition: 'manthan',
                            link: _linkController.text.trim(),
                          );
                          if (!mounted) return;

                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(ScoreBoardHome.id, (route) => false);
                          showSnackBar(context, 'Successfully added/updated result');
                          ManthanResultFormStore.clear();
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
                        itemCount: ManthanResultFormStore.numPositions() + 2,
                        itemBuilder: (context, index) {
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
                                          widget.event.module,
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
                                  height: 22,
                                ),
                                CustomTextField(
                                  inputType: TextInputType.text,
                                  hintText: 'Victory Statement',
                                  validator: validateField,
                                  value: ManthanResultFormStore.victoryStatement,
                                  onChanged: (p) {
                                    ManthanResultFormStore.victoryStatement = p;
                                  },
                                  isNecessary: true,
                                ),
                                const SizedBox(
                                  height: 16,
                                )
                              ],
                            );
                          }
                          index--;
                          return Column(children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text(
                                    getPosition(index - 1),
                                    style: bodyText2,
                                  ),
                                ]),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomDropDown(
                                  validator: validateField,
                                  value: ManthanResultFormStore.resultFields?[index - 1].hostelName,
                                  onChanged: (hostel) => ManthanResultFormStore
                                      .resultFields?[index - 1].hostelName = hostel,
                                  items: allHostelList,
                                  hintText: 'Hostels', // multiple times same hostels can be in list
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(children: [
                                  Expanded(
                                    flex: 46,
                                    child: CustomTextField(
                                      inputType: TextInputType.number,
                                      isNecessary: true,
                                      hintText: 'Primary Score',
                                      validator: validateField,
                                      onChanged: (ps) => ManthanResultFormStore
                                          .resultFields?[index - 1].primaryScore = double.parse(ps),
                                      value: ManthanResultFormStore
                                          .resultFields?[index - 1].primaryScore
                                          .toString(),
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
                                        onChanged: (ss) => ManthanResultFormStore
                                            .resultFields?[index - 1].secondaryScore = ss,
                                        value: ManthanResultFormStore
                                            .resultFields?[index - 1].secondaryScore,
                                      )),
                                ]),
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
                                if (index == ManthanResultFormStore.resultFields!.length)
                                  TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          ManthanResultFormStore.addNewPosition(index - 1);
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
                          ]);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
