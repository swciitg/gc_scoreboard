import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../functions/snackbar.dart';
import '../../../functions/validator.dart';
import '../../../globals/colors.dart';
import '../../../globals/constants.dart';
import '../../../globals/enums.dart';
import '../../../globals/styles.dart';
import '../../../models/standing_model.dart';
import '../../../services/api.dart';
import '../../../stores/common_store.dart';
import '../../../stores/standing_form_store.dart';
import '../../../widgets/fields/drop_down.dart';
import '../../../widgets/fields/custom_text_field.dart';
import '../../../functions/position.dart';
import '../../../widgets/fields/autocomplete.dart';
import '../../../widgets/ui/heading.dart';
import '../../home.dart';

class AddStanding extends StatefulWidget {
  final StandingModel? standings;

  const AddStanding({super.key, this.standings});

  @override
  State<AddStanding> createState() => _AddStandingState();
}

class _AddStandingState extends State<AddStanding> {
  TextEditingController victoryStatement = TextEditingController();
  final StandingFormStore standingFormStore = StandingFormStore();

  void callbackAutocomplete(String value){
    standingFormStore.event=value;
  }
  
  @override
  void initState() {
    super.initState();
    if (widget.standings != null) {
      standingFormStore.setPreData(widget.standings!);
    }
  }

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    var commStore = context.read<CommonStore>();
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
                widget.standings == null ? 'Add Standings' : 'Edit Standings',
                style: headline2,
              ),
              leading: IconButton(
                onPressed: () {
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
                    if (!key.currentState!.validate()) {
                      return;
                    }
                    if (isLoading) {
                      showSnackBar(context, 'Please wait before trying again');
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        if (widget.standings == null) {
                          await APIService(context).postSpardhaStanding({
                            "category":
                                standingFormStore.category!.categoryName,
                            'event': standingFormStore.event,
                            'standings': List<Map>.from(standingFormStore
                                .standing!
                                .map((e) => e.toJson()))
                          });
                          if (!context.mounted) return;

                          showSnackBar(context, "Standing added");
                        } else {
                          widget.standings!.category =
                              standingFormStore.category!.categoryName;
                          widget.standings!.event = standingFormStore.event;
                          widget.standings!.standings =
                              standingFormStore.standing;
                          await APIService(context)
                              .updateSpardhaStanding(widget.standings!);
                          if (!context.mounted) return;

                          showSnackBar(context, "Standing updated");
                        }
                        commStore.competition = Competitions.gc;
                        if (!mounted) return;
                        Navigator.pushNamedAndRemoveUntil(
                            context, ScoreBoardHome.id, (route) => false);
                      } on DioException catch (err) {
                        showErrorSnackBar(context, err);
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: Text(
                    'Next',
                    style: headline3,
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
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: AutocompleteTextField(callbackFunction: callbackAutocomplete, standings: widget.standings?.event,),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: double.infinity,
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
                                    standingFormStore.category =
                                        Category.menandwomen;
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
                                        style: bodyText2,
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
                                        child: CustomDropDown(
                                          validator: validateField,
                                          value:standingFormStore
                                                .standing![index - 1].hostelName ,
                                          onChanged: (hostel) =>
                                                standingFormStore
                                                    .standing![index - 1]
                                                    .hostelName = hostel,
                                          items: getHostel(
                                                  standingFormStore.category), hintText: 'Hostels' ,
                                        ),

                                      ),
                                      if (index > 0)
                                        const Spacer(
                                          flex: 10,
                                        ),
                                      if (index > 0) Container(),
                                      Expanded(
                                        flex: 35,
                                        child: CustomTextField(
                                          isNecessary: true,
                                          inputType: TextInputType.number,
                                          hintText: 'Points',
                                          validator: validateField,
                                          onChanged: (ps) {
                                            standingFormStore
                                                .standing![index - 1]
                                                .points = double.parse(ps);
                                          },
                                          value: standingFormStore
                                              .standing![index - 1].points
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
                                  const Divider(
                                    thickness: 1,
                                    color: Themes.dividerColor1,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                    )),
                  ],
                ),
              ),
            )));
  }
}
