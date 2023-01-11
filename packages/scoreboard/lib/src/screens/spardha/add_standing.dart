import 'package:flutter/material.dart';
import 'package:scoreboard/src/globals/constants.dart';
import 'package:scoreboard/src/globals/enums.dart';
import 'package:scoreboard/src/models/standing_model.dart';
import 'package:scoreboard/src/services/api.dart';
import 'package:scoreboard/src/widgets/add_event/drop_down.dart';
import 'package:scoreboard/src/widgets/add_result/hostel_dropdown.dart';
import '../../functions/validator.dart';
import '../../globals/colors.dart';
import '../../stores/standing_form_store.dart';
import '../../widgets/add_result/custom_text_field.dart';
import '../../widgets/add_result/fields_mandatory.dart';
import '../../functions/position.dart';

class AddStanding extends StatefulWidget {
  final StandingModel? standings;

  const AddStanding({super.key, this.standings});

  @override
  State<AddStanding> createState() => _AddStandingState();
}

class _AddStandingState extends State<AddStanding> {
  TextEditingController victoryStatement = TextEditingController();

  final StandingFormStore abc = StandingFormStore();

  @override
  void initState() {
    super.initState();

    abc.setPreData(widget.standings);
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();

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
            widget.standings == null ? 'Add Standings' : 'Edit Standings',
            style: Themes.theme.textTheme.headline2,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              color: Themes.theme.primaryColor,
            ),
            splashColor: const Color.fromRGBO(118, 172, 255, 0.9),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (widget.standings == null) {
                  APIService(context).postSpardhaStanding({
                    "category": abc.category!.categoryName,
                    'event': abc.event,
                    'standings':
                        List<Map>.from(abc.standing!.map((e) => e.toJson()))
                  });
                } else {
                  final StandingModel model = StandingModel(category: abc.category!.categoryName,event: abc.event,standings:abc.standing );
                  APIService(context).updateSpardhaStanding(model);
                }

                // print('button pressed');
                // if (key.currentState!.validate()) {
                //   print('submit result pressed');
                //   bool respose = await APIService(context).addUpdateResult(
                //       widget.standings!.id!,
                //       StandingFormStore.resultFields!,
                //       StandingFormStore.victoryStatement!);
                //   if (respose) {
                //     Navigator.of(context).pushNamedAndRemoveUntil(
                //         ScoreBoardHome.id, (route) => false);
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text('Success')),
                //     );
                //     StandingFormStore.clear();
                //   } else {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text('Failed')),
                //     );
                //   }
                // }
              },
              child: Text(
                'Next',
                style: Themes.theme.textTheme.headline3,
              ),
            )
          ],
        ),
        body: Container(
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
                  Expanded(
                    flex: 30,
                    child: CustomTextField(
                        hintText: 'Event',
                        validator: validateField,
                        value: widget.standings!.event,
                        onChanged: (ps) {
                          // print(standing.event);
                          abc.event = ps;
                        },
                        isNecessary: true),
                  ),
                  const Spacer(
                    flex: 10,
                  ),
                  Expanded(
                    flex: 30,
                    child: CustomDropDown(
                        items: eventCategories,
                        hintText: 'Category',
                        onChanged: (ps) {
                          setState(() {
                            abc.clearStandings();
                            if (ps == "Men") {
                              abc.category = Category.men;
                            } else if (ps == 'Women') {
                              abc.category = Category.women;
                            } else {
                              abc.category = Category.menandwomen;
                            }
                            print(ps);
                          });
                        },
                        validator: validateField),
                  ),
                ],
              ),
              Expanded(
                  child: Form(
                key: key,
                child: ListView.builder(
                  itemCount: abc.standing!.length + 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (index > 0)
                              Row(
                                children: [
                                  Text(
                                    getPosition(index - 1),
                                    style: Themes.theme.textTheme.bodyText2,
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (index > 0)
                              Row(
                                children: [
                                  Expanded(
                                    flex: 50,
                                    child: HostelDropDown(
                                      validator: validateField,
                                      value:
                                          abc.standing![index - 1].hostelName,
                                      onChanged: (hostel) => abc
                                          .standing![index - 1]
                                          .hostelName = hostel,
                                      hostels: getHostel(abc.category),
                                    ),
                                  ),
                                  if (index > 0)
                                    const Spacer(
                                      flex: 10,
                                    ),
                                  if (index > 0)
                                    Expanded(
                                      flex: 35,
                                      child: CustomTextField(
                                        isNecessary: true,
                                        hintText: 'Primary Score',
                                        validator: validateField,
                                        onChanged: (ps) {
                                          abc.standing![index - 1].points =
                                              int.parse(ps);
                                        },
                                        value: abc.standing![index - 1].points
                                            .toString(),
                                      ),
                                    ),
                                ],
                              ),
                            if (index > 0)
                              const SizedBox(
                                height: 16,
                              ),
                            if (index > 0)
                              Divider(
                                thickness: 1,
                                color: Themes.theme.dividerColor,
                              ),
                            if (index > 0)
                              const SizedBox(
                                height: 24,
                              ),
                            if (index == abc.standing!.length)
                              TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      abc.addNewPosition();
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
              )),
            ],
          ),
        ));
  }
}
