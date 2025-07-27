import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../functions/snackbar.dart';
import '../../../functions/validator.dart';
import '../../../globals/colors.dart';
import '../../../globals/constants.dart';
import '../../../globals/styles.dart';
import '../../../models/sahyog_models/sahyog_event_model.dart';
import '../../../services/api.dart';
import '../../../widgets/fields/datepicker_color.dart';
import '../../../widgets/fields/drop_down.dart';
import '../../../widgets/ui/heading.dart';
import '../../../widgets/fields/timepicker_color.dart';
import '../../../widgets/fields/custom_text_field.dart';
import '../../../widgets/fields/autocomplete.dart';
import '../../../widgets/common/form_app_bar.dart';
import '../../../globals/enums.dart';
import '../../home.dart';

class SahyogEventForm extends StatefulWidget {
  final SahyogEventModel? event;
  const SahyogEventForm({super.key, this.event});

  @override
  State<SahyogEventForm> createState() => _SahyogEventFormState();
}

class _SahyogEventFormState extends State<SahyogEventForm> {
  List<String> clubNames = SahyogClub.values.map((e) => e.clubName).toList();
  bool isLoading = false;
  String? eventName;
  DateTime? date;
  TimeOfDay? time;
  double? points;
  String? difficulty;
  int clubSize = 0;
  String? clubSizeValue;
  List<String?> clubs = [];
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _probelmLinkController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController timeInput = TextEditingController();

  void callbackClubs(String value) {
    clubs.length = int.parse(value);
    setState(() {
      clubSize = int.parse(value);
      clubSizeValue = clubSize.toString();
    });
  }

  void callbackAddClub(String value, int index) {
    clubs[index - 1] = value;
    clubSizeValue = clubs.length.toString();
  }

  void callbackAutocomplete(String value) {
    eventName = value;
  }

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      SahyogEventModel e = widget.event!;
      eventName = e.event;
      _venueController.text = e.venue;
      _linkController.text = e.link;
      difficulty = e.difficulty;
      clubSize = e.clubs.length;
      _probelmLinkController.text = e.problemLink;
      points = e.points;

      for (var club in e.clubs) {
        clubs.add(club);
      }

      clubSizeValue = clubs.length.toString();
      date = e.date;
      time = TimeOfDay(hour: e.date.hour, minute: e.date.minute);
      dateInput.text = DateFormat('dd-MMM-yyyy').format(e.date);
      timeInput.text = DateFormat('h:mm a').format(e.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    clubNames.remove("Overall");

    Future<void> onFormSubmit() async {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        if (!_formKey.currentState!.validate()) {
          showSnackBar(context, 'Please give all the inputs correctly');
          setState(() {
            isLoading = false;
          });
          return;
        } else {
          DateTime eventDateTime =
              DateTime(date!.year, date!.month, date!.day, date!.hour, date!.minute);

          var data = {
            "event": eventName,
            "difficulty": difficulty,
            "date": eventDateTime.toIso8601String(),
            "venue": _venueController.text,
            "clubs": clubs,
            "points": points,
            "problemLink": _probelmLinkController.text,
            "results": [],
            "resultAdded": false,
            "link": _linkController.text,
          };
          if (widget.event != null) {
            data['_id'] = widget.event!.id;
          }

          try {
            if (widget.event != null) {
              //update event schedule
              await APIService(context).updateEventSchedule(data: data, competition: 'sahyog');
              if (!context.mounted) return;
              showSnackBar(context, "Event Edited successfully");
            } else {
              await APIService(context).postEventSchedule(data: data, competiton: 'sahyog');
             if (!context.mounted) return;
              showSnackBar(context, "Event schedule posted successfully");
            }
            if (!mounted) return;
            setState(() {
              isLoading = true;
            });
            Navigator.pushNamedAndRemoveUntil(context, ScoreBoardHome.id, (route) => false);
          } on DioException catch (err) {
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
            actionTitle: "Submit",
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
                      AutocompleteTextField(
                        callbackFunction: callbackAutocomplete,
                        standings: widget.event?.event,
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
                        controller: _probelmLinkController,
                        isNecessary: true,
                      ),
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
                                FocusScope.of(context).requestFocus(FocusNode());
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: date ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101),
                                    builder: (context, child) => CustomDatePicker(
                                          child: child,
                                        ));
                                if (pickedDate != null) {
                                  if (!mounted) return;
                                  date = pickedDate;
                                  String formattedDate =
                                      DateFormat('dd-MMM-yyyy').format(pickedDate);
                                  setState(() {
                                    dateInput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                }
                              },
                              isNecessary: true,
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
                                FocusScope.of(context).requestFocus(FocusNode());
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
                                    final formattedTimeString = DateFormat.jm().format(DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        pickedTime.hour,
                                        pickedTime.minute)); //"6:00 AM"
                                    timeInput.text = formattedTimeString;
                                  });
                                }
                              },
                              isNecessary: true,
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
                        controller: _venueController,
                        isNecessary: true,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        hintText: 'Score link',
                        validator: (val) {
                          return null;
                        },
                        controller: _linkController,
                        isNecessary: false,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Clubs',
                        style: headline1,
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
