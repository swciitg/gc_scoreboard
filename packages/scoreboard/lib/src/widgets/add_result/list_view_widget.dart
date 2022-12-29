import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scoreboard/src/models/event_model.dart';
import 'package:scoreboard/src/stores/result_form_store.dart';
import '../../functions/schedule_event/validator.dart';
import './hostel_dropdown.dart';
import './custom_text_field.dart';

import '../../globals/themes.dart';

class AddResultList extends StatefulWidget {
  const AddResultList({super.key});

  @override
  State<AddResultList> createState() => _AddResultListState();
}

class _AddResultListState extends State<AddResultList> {
   String _positionSuffix(int count) {
    if (count == 1) return 'st';
    if (count == 2) return 'nd';
    if (count == 3) return 'rd';
    return 'th';
  }

  @override
  Widget build(BuildContext context) {
   
    return Expanded(
        child: Form(
      child: ListView.builder(
        itemCount: ResultForm.numResults,
        itemBuilder: (context, index) {
          String formKey =
              "FormField${ResultForm.resultFields![index].position}";
          if (index != 0 &&
              ResultForm.resultFields![index - 1].position ==
                  ResultForm.resultFields![index].position) {
            formKey += "Tie";
          }
          return Column(
            key: Key(formKey),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${ResultForm.resultFields![index].position}${_positionSuffix((ResultForm.resultFields![index].position))} Position',
                    style: Themes.theme.textTheme.bodyText2,
                  ),
                  const Spacer(),
                  if (ResultForm.displayAddTieIcon(index))
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
                        setState(() {
                        ResultForm
                            .addTie(ResultForm.resultFields![index].position);
                          
                        });
                      },
                    ),
                  if (ResultForm.displayRemoveTieIcon(index))
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
                        setState(() {
                          
                        ResultForm.removePosition(index);
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
                    child: HostelDropDown(
                      value: ResultForm.resultFields?[index].hostel,
                      onChanged: (hostel) =>
                          ResultForm.resultFields?[index].hostel = hostel,
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
                        validator: validateField,
                        onChanged: (p) => ResultForm
                            .resultFields?[index].points = int.tryParse(p),
                        value:
                            ResultForm.resultFields?[index].points.toString(),
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
                      validator: validateField,
                      onChanged: (ps) =>
                          ResultForm.resultFields?[index].primaryScore = ps,
                      value: ResultForm.resultFields?[index].primaryScore,
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
                        onChanged: (ss) => ResultForm
                            .resultFields?[index].secondaryScore = ss,
                        value: ResultForm.resultFields?[index].secondaryScore,
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
              if (ResultForm.displayAddPosition(index))
                TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      setState(() {
                        
                      ResultForm.addNewPosition(
                          ResultForm.resultFields?[index].position);
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                          style: Themes.theme.textTheme.headline3,
                        )
                      ],
                    ))
            ],
          );
        },
      ),
    ));
  }
}
