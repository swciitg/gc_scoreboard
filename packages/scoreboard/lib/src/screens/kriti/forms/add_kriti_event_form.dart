import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoreboard/src/globals/colors.dart';
import 'package:scoreboard/src/models/kriti_models/kriti_event_model.dart';
import 'package:scoreboard/src/services/api.dart';
import 'package:scoreboard/src/widgets/add_result/custom_text_field.dart';

import '../../../functions/snackbar.dart';
import '../../../functions/validator.dart';
import '../../../globals/constants.dart';
import '../../../stores/static_store.dart';
import '../../../widgets/add_event/datepicker_color.dart';
import '../../../widgets/add_event/drop_down.dart';
import '../../../widgets/add_event/heading.dart';
import '../../../widgets/add_event/text_field.dart';
import '../../../widgets/add_event/timepicker_color.dart';
import '../../../widgets/common/form_app_bar.dart';
import '../../../globals/enums.dart';
import '../../home.dart';



class AddKritiEventForm extends StatefulWidget {
  final KritiEventModel? event;
  const AddKritiEventForm({Key? key, this.event}) : super(key: key);

  @override
  State<AddKritiEventForm> createState() => _AddKritiEventFormState();
}

class _AddKritiEventFormState extends State<AddKritiEventForm> {
  List<String> cupNames = Cup.values.map((e) => e.cupName).toList();

  List<String> clubNames = Club.values.map((e) => e.clubName).toList();
  bool isLoading = false;
  String? eventName;
  DateTime? date;
  TimeOfDay? time;
  double? points;

  String? cup;
  String? difficulty;
  int clubSize = 0;
  String? clubSizeValue;
  List<String?> clubs = [];
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _probelmLinkController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController timeInput = TextEditingController();

  callbackClubs(value) {
    clubs.length = int.parse(value);
    setState(() {
      clubSize = int.parse(value);
      clubSizeValue = clubSize.toString();
    });
  }

  callbackAddClub(value, index) {
    clubs[index - 1] = value;
    clubSizeValue = clubs.length.toString();
  }

  @override
  void initState() {
    super.initState();
    if( widget.event != null){
      KritiEventModel e = widget.event!;
      eventName = e.event;
      _venueController.text = e.venue;
      cup = e.cup;
      difficulty = e.difficulty;
      clubSize = e.clubs.length;
      _probelmLinkController.text = e.problemLink;
      points =  e.points;

      for (var club in e.clubs) {
        clubs.add(club);
      }
      print(clubs);

      clubSizeValue = clubs.length.toString();
      date = e.date;
      time = TimeOfDay(hour: e.date.hour, minute: e.date.minute);
      dateInput.text = DateFormat('dd-MMM-yyyy').format(e.date);
      timeInput.text = DateFormat('h:mm a').format(e.date);




    }





  }
  @override
  Widget build(BuildContext context) {
    cupNames.remove("Overall"); // overall can't be a cup category in this form
    clubNames.remove("Overall");

    Future<void> onFormSubmit() async {
      if(!isLoading) {
        setState(() {
          isLoading = true;
        });
      if (!_formKey.currentState!.validate()) {
        showSnackBar(context, 'Please give all the inputs correctly');
        setState(() {
          isLoading = false;
        });
        return;
      }
      else {
        DateTime eventDateTime = DateTime(
            date!.year,
            date!.month,
            date!.day,
            date!.hour,
            date!.minute);

        var data = {
          "event": eventName,
          "cup": cup,
          "difficulty": difficulty,
          "date": eventDateTime.toIso8601String(),
          "venue": _venueController.text,
          "clubs": clubs,
          "points": points,
          "problemLink": _probelmLinkController.text,
          "results": [],
          "resultAdded": false,

        };
        if (widget.event != null) {
          data['_id'] = widget.event!.id;
        }

        try {
          if (widget.event != null) {
            // update event schedule
            await APIService(context).updateKritiEvent(
                KritiEventModel.fromJson(data));
            if (!mounted) return;
            showSnackBar(context, "Event Edited successfully");
          } else {
            await APIService(context).postKritiEventSchedule(data);
            if (!mounted) return;
            showSnackBar(
                context, "Event schedule posted successfully");
          }
          if (!mounted) return;
          setState(() {
            isLoading = true;
          });
          Navigator.pushNamedAndRemoveUntil(
              context, ScoreBoardHome.id, (route) => false);
        }
        on DioError catch (err) {
          showErrorSnackBar(context, err);
          setState(() {
            isLoading = false;
          });
        }
      }
    }
    }

    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: AppBarFormComponent(
            title: widget.event == null ? 'Add Event' : 'Edit Event',
            actionTitle: "Next",
            onFormSubmit: onFormSubmit,
          )),


      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const EventFormHeading(),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Autocomplete<String>(
                        optionsBuilder: (TextEditingValue val) {
                          if (val.text == '') {
                            return const Iterable<String>.empty();
                          }
                          return StaticStore.kritiEvents.where((element) =>
                              element
                                  .toLowerCase()
                                  .contains(val.text.toLowerCase()));
                        },
                        initialValue:
                        TextEditingValue(text: widget.event?.event ?? ""),
                        onSelected: (s) => eventName = s,
                        optionsMaxHeight: 50,
                        optionsViewBuilder: (BuildContext context,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options) {
                          // options = [...options,...options,...options,...options,...options,...options,...options,];
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              color: Colors.transparent,
                              child: ListView.builder(
                                // padding: EdgeInsets.all(10.0),
                                padding:
                                const EdgeInsets.symmetric(vertical: 0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option =
                                  options.elementAt(index);
                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: ListTile(
                                      tileColor: Themes.theme.backgroundColor,
                                      title: Text(option,
                                          style:
                                          Themes.theme.textTheme.headline6),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        fieldViewBuilder: (context, c, f, __) {
                          return CustomTextField(
                            hintText: 'Event Name',
                            validator: (s) {
                              if (StaticStore.kritiEvents.contains(s)) {
                                return null;
                              }
                              return "Enter a valid event";
                            },
                            controller: c,
                            focusNode: f,
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      CustomDropDown(
                        items: cupNames,
                        hintText: 'Cup Category',
                        onChanged: (s) {
                          cup = s;
                        },
                        value: cup,
                        validator: validateField,
                      ),
                      const SizedBox(height: 12),
                      CustomDropDown(
                        items: kritiDifficulties,
                        hintText: 'Difficulty',
                        onChanged: (s) => difficulty = s,
                        value: difficulty,
                        validator: validateField,
                      ),
                      const SizedBox(height: 12),

                      CustomTextField(
                          hintText: 'Problem Link',
                          validator: validateField,
                          controller: _probelmLinkController),

                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hintText: 'Date',
                              validator: validateField,
                              controller: dateInput,
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: date ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101),
                                    builder: (context, child) =>
                                        DatePickerTheme(
                                          child: child,
                                        ));
                                if (pickedDate != null) {
                                  if (!mounted) return;
                                  date = pickedDate;
                                  String formattedDate =
                                  DateFormat('dd-MMM-yyyy')
                                      .format(pickedDate);
                                  setState(() {
                                    dateInput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: CustomTextField(
                              hintText: 'Time',
                              validator: validateField,
                              controller: timeInput,
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                TimeOfDay? pickedTime = await showTimePicker(
                                  builder: (context, childWidget) {
                                    return TimePickerColor(
                                      childWidget: childWidget,
                                    );
                                  },
                                  initialTime: time ?? TimeOfDay.now(),
                                  context: context,
                                  //context of current state
                                );
                                if (pickedTime != null) {
                                  if (!mounted) return;
                                  time = pickedTime;
                                  setState(() {
                                    final now = DateTime.now();
                                    final formattedTimeString = DateFormat.jm()
                                        .format(DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        pickedTime.hour,
                                        pickedTime.minute)); //"6:00 AM"
                                    timeInput.text = formattedTimeString;
                                  });
                                }
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                          hintText: 'Venue',
                          validator: validateField,
                          controller: _venueController),
                      const SizedBox(
                        height: 12,
                      ),

                      Text(
                        'Clubs',
                        style: Themes.theme.textTheme.headline1,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      CustomDropDown(
                        items: [for (var i = 1; i <= 15; i++) i.toString()],
                        value: clubSizeValue,
                        hintText: 'Select Number of Clubs',
                        onChanged: callbackClubs,
                        validator: validateField,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Column(
                        children: [
                          for (var i = 1; i <= clubSize; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: CustomDropDown(
                                items: clubNames,
                                value: clubs[i - 1],
                                hintText: 'Club Name $i',
                                index: i,
                                validator: validateField,
                                onChanged: callbackAddClub,
                              ),
                            )
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),


    );
  }
}