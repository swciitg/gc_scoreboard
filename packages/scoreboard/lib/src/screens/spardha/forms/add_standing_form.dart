import 'package:flutter/material.dart';
import 'package:scoreboard/src/globals/constants.dart';
import 'package:scoreboard/src/globals/enums.dart';
import 'package:scoreboard/src/models/standing_model.dart';
import 'package:scoreboard/src/screens/home.dart';
import 'package:scoreboard/src/services/api.dart';
import 'package:scoreboard/src/stores/static_store.dart';
import 'package:scoreboard/src/widgets/add_event/drop_down.dart';
import 'package:scoreboard/src/widgets/add_result/hostel_dropdown.dart';
import '../../../functions/snackbar.dart';
import '../../../functions/validator.dart';
import '../../../globals/colors.dart';
import '../../../stores/standing_form_store.dart';
import '../../../widgets/add_result/custom_text_field.dart';
import '../../../widgets/add_result/fields_mandatory.dart';
import '../../../functions/position.dart';

class AddStanding extends StatefulWidget {
  final StandingModel? standings;

  const AddStanding({super.key, this.standings});

  @override
  State<AddStanding> createState() => _AddStandingState();
}

class _AddStandingState extends State<AddStanding> {
  TextEditingController victoryStatement = TextEditingController();

  final StandingFormStore standingFormStore = StandingFormStore();

  @override
  void initState() {
    super.initState();
    if(widget.standings != null)
      {
        standingFormStore.setPreData(widget.standings!);
      }
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
                if (!key.currentState!.validate()) {
                  return;
                }
                try {
                  bool response;
                  if (widget.standings == null) {
                    response = await APIService(context).postSpardhaStanding({
                      "category": standingFormStore.category!.categoryName,
                      'event': standingFormStore.event,
                      'standings': List<Map>.from(
                          standingFormStore.standing!.map((e) => e.toJson()))
                    });
                  } else {
                    widget.standings!.category=standingFormStore.category!.categoryName;
                    widget.standings!.event=standingFormStore.event;
                    widget.standings!.standings=standingFormStore.standing;
                    response =
                    await APIService(context).updateSpardhaStanding(widget.standings!);
                  }
                  if (response) {
                    showSnackBar(context, "Done Successfully");
                    Navigator.pushNamedAndRemoveUntil(context, ScoreBoardHome.id, (route) => false);
                  }
                  else {
                    showSnackBar(
                        context, 'Some error occured, please try again');
                  }
                }
                catch(err)
                {
                  print(err.toString());
                  showSnackBar(
                      context, 'Some error occured, please try again');
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
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          width: double.infinity,
          child: Form(
            key: key,
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
                      child: CustomDropDown(
                          items: StaticStore.spardhaEvents,
                          hintText: 'Event',
                          value: standingFormStore.event,
                          onChanged: (value) {
                            setState(() {
                              standingFormStore.event = value;
                            });
                          },
                          validator: validateField),
                    ),
                    const Spacer(
                      flex: 10,
                    ),
                    Expanded(
                      flex: 30,
                      child: CustomDropDown(
                          items: eventCategories,
                          hintText: 'Category',
                          value: standingFormStore.category?.categoryName,
                          onChanged: (value) {
                            setState(() {
                              standingFormStore.clearStandings();
                              if (value == "Men") {
                                standingFormStore.category = Category.men;
                              } else if (value == 'Women') {
                                standingFormStore.category = Category.women;
                              } else {
                                standingFormStore.category = Category.menandwomen;
                              }
                            });
                          },
                          validator: validateField),
                    ),
                  ],
                ),
                Expanded(
                    child: ListView.builder(
                      itemCount: standingFormStore.standing!.length + 1,
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
                                              standingFormStore.standing![index - 1].hostelName,
                                          onChanged: (hostel) => standingFormStore
                                              .standing![index - 1]
                                              .hostelName = hostel,
                                          hostels: getHostel(standingFormStore.category),
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
                                            inputType: TextInputType.number,
                                            hintText: 'Primary Score',
                                            validator: validateField,
                                            onChanged: (ps) {
                                              standingFormStore.standing![index - 1].points =
                                                  int.parse(ps);
                                            },
                                            value: standingFormStore.standing![index - 1].points
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
                                if (index == standingFormStore.standing!.length)
                                  TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          standingFormStore.addNewPosition();
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
                    )),
              ],
            ),
          ),
        ));
  }
}
