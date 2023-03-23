import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../functions/position.dart';
import '../../../functions/snackbar.dart';
import '../../../functions/validator.dart';
import '../../../globals/colors.dart';
import '../../../globals/constants.dart';
import '../../../models/kriti_models/kriti_event_model.dart';
import '../../../services/api.dart';
import '../../../widgets/fields/drop_down.dart';
import '../../../widgets/fields/custom_text_field.dart';
import '../../../widgets/cards/card_date_widget.dart';
import '../../../widgets/ui/heading.dart';
import '../../home.dart';
import 'kriti_result_store.dart';

class KritiResultForm extends StatefulWidget {
  final KritiEventModel event;
  const KritiResultForm({super.key, required this.event});

  @override
  State<KritiResultForm> createState() => _KritiResultFormState();
}

class _KritiResultFormState extends State<KritiResultForm> {
  TextEditingController victoryStatement = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.event.results.isNotEmpty) {
      KritiResultFormStore.resultFields = widget.event.results;
      KritiResultFormStore.victoryStatement = widget.event.victoryStatement!;
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
                  KritiResultFormStore.clear();
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
                          await APIService(context).addUpdateKritiResult(
                              widget.event.id!,
                              KritiResultFormStore.resultFields!,
                              KritiResultFormStore.victoryStatement!);
                          if (!mounted) return;

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              ScoreBoardHome.id, (route) => false);
                          showSnackBar(
                              context, 'Successfully added/updated result');
                          KritiResultFormStore.clear();
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
                        itemCount: KritiResultFormStore.numPositions() + 1,
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
                                          widget.event.cup,
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
                                    widget.event.difficulty,
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
                                  value: KritiResultFormStore.victoryStatement,
                                  onChanged: (p) {
                                    KritiResultFormStore.victoryStatement = p;
                                  },
                                  isNecessary: true,
                                ),
                                const SizedBox(
                                  height: 16,
                                )
                              ],
                            );
                          } else {
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
                                      style: Themes.theme.textTheme.bodyText2,
                                    ),
                                  ]),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomDropDown(
                                    validator: validateField,
                                    value: KritiResultFormStore
                                        .resultFields?[index - 1].hostelName,
                                    onChanged: (hostel) => KritiResultFormStore
                                        .resultFields?[index - 1]
                                        .hostelName = hostel,
                                    items:
                                        allHostelList, hintText: 'Hostels', // multiple times same hostels can be in list
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomTextField(
                                    inputType: TextInputType.number,
                                    isNecessary: true,
                                    hintText: 'Points',
                                    validator: validateField,
                                    onChanged: (ps) => KritiResultFormStore
                                        .resultFields?[index - 1]
                                        .points = double.parse(ps),
                                    value: KritiResultFormStore
                                        .resultFields?[index - 1].points
                                        .toString(),
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
                                  if (index ==
                                      KritiResultFormStore.resultFields!.length)
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            KritiResultFormStore.addNewPosition(
                                                index - 1);
                                          });
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
                                              style: Themes
                                                  .theme.textTheme.headline3,
                                            )
                                          ],
                                        ))
                                ],
                              )
                            ]);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
