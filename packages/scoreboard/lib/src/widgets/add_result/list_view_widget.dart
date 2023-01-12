import 'package:flutter/material.dart';
import '../../functions/position.dart';
import '../../functions/validator.dart';
import '../../stores/result_form_store.dart';
import './hostel_dropdown.dart';
import './custom_text_field.dart';
import '../../globals/colors.dart';

class AddResultList extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final List<String> hostels;
  const AddResultList(
      {super.key, required this.formKey, required this.hostels});

  @override
  State<AddResultList> createState() => _AddResultListState();
}

class _AddResultListState extends State<AddResultList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: ResultFormStore.numPositions()+1,
        itemBuilder: (context, index) {
          if (index == 0) {
 return CustomTextField(
              inputType: TextInputType.text,
              hintText: 'Victory Statement',
              validator: validateField,
              value: ResultFormStore.victoryStatement,
              onChanged: (p) {
                ResultFormStore.victoryStatement = p;
              },
              isNecessary: true,
            );
          }
          index--;
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
                                ResultFormStore.addTeamAtPosition(index + 1);
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
                          child: HostelDropDown(
                            validator: validateField,
                            value: ResultFormStore
                                .resultFields?[index][team].hostelName,
                            onChanged: (hostel) => ResultFormStore
                                .resultFields?[index][team].hostelName = hostel,
                            hostels: widget.hostels,
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
                                  .resultFields?[index][team]
                                  .secondaryScore = ss,
                              value: ResultFormStore
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
    );
  }
}
