import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Form(
      child: ListView.builder(
        itemCount: ResultForm.resultFields!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              for(int team = 0; team < ResultForm.resultFields![index].length; team++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${index + 1} Position',
                          style: Themes.theme.textTheme.bodyText2,
                        ),
                        const Spacer(),
                        if (team == 0)
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
                                ResultForm.addTeamAtPosition(index);
                              });
                            },
                          ),
                        if (team != 0)
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
                                ResultForm.removeTeamAtPosition(index, team);
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
                            value: ResultForm.resultFields?[index][team].hostel,
                            onChanged: (hostel) => ResultForm
                                .resultFields?[index][team].hostel = hostel,
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
                                  .resultFields?[index][team]
                                  .points = int.tryParse(p),
                              value: ResultForm.resultFields?[index][team].points
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
                            validator: validateField,
                            onChanged: (ps) => ResultForm
                                .resultFields?[index][team].primaryScore = ps,
                            value:
                            ResultForm.resultFields?[index][team].primaryScore,
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
                                  .resultFields?[index][team].secondaryScore = ss,
                              value: ResultForm
                                  .resultFields?[index][team].secondaryScore,
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
                    if (index + 1 == ResultForm.resultFields!.length && team+1 == ResultForm.resultFields![index].length)
                      TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            setState(() {
                              ResultForm.addNewPosition(index);
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
                )
            ],
          );
        },
      ),
    ));
  }
}
