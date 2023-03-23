import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../../functions/snackbar.dart';
import '../../../functions/validator.dart';
import '../../../globals/colors.dart';
import '../../../globals/enums.dart';
import '../../../models/manthan_models/manthan_event_model.dart';
import '../../../services/api.dart';
import '../../../stores/static_store.dart';
import '../../../widgets/fields/datepicker_color.dart';
import '../../../widgets/fields/drop_down.dart';
import '../../../widgets/ui/heading.dart';
import '../../../widgets/fields/timepicker_color.dart';
import '../../../widgets/fields/custom_text_field.dart';
import '../../../widgets/fields/autocomplete.dart';
import '../../../widgets/common/form_app_bar.dart';
import '../../home.dart';
// import 'confirm_event_details.dart';

class ManthanEventForm extends StatefulWidget {
  final ManthanEventModel? event;

  const ManthanEventForm({super.key, this.event});

  @override
  State<ManthanEventForm> createState() => _ManthanEventFormState();
}

class _ManthanEventFormState extends State<ManthanEventForm> {
  List<String> moduleNames = Module.values.map((e) => e.moduleName).toList();

  bool isLoading = false;
  String? eventName;
  DateTime? date; // stores date picked
  TimeOfDay? time; // stores time picked
  String? module; // Men/Women
  // String? stage;
  // String? hostelSizeValue;
  // int hostelsSize = 0;
  // List<String?> participatingHostels = [];
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController timeInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  callbackAutocomplete(value){
    eventName=value;
  }

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      ManthanEventModel e = widget.event!;
      eventName = e.event;
      _venueController.text = e.venue;
      module = e.module;
      date = e.date;
      time = TimeOfDay(hour: e.date.hour, minute: e.date.minute);
      dateInput.text = DateFormat('dd-MMM-yyyy').format(e.date);
      timeInput.text = DateFormat('h:mm a').format(e.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> onFormSubmit() async {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        if (!_formKey.currentState!.validate()) {
          showSnackBar(context, 'Please give all the inputs correctly');
          return;
        } else {
          DateTime eventDateTime = DateTime(
              date!.year, date!.month, date!.day, time!.hour, time!.minute);

          var data = {
            "event": eventName,
            "module": module!,
            "date": eventDateTime.toIso8601String(),
            "venue": _venueController.text,
            "results": [],
            "resultAdded": false
          };

          if (widget.event != null) {
            data['_id'] = widget.event!.id;
          }
          try {
            if (widget.event != null) {
              // update event schedule
              await APIService(context).updateEventSchedule(data: data, competition: 'manthan');
              if (!mounted) return;
              showSnackBar(context, "Event Edited successfully");
            } else {
              await APIService(context).postEventSchedule(data: data, competiton: 'manthan');
              if (!mounted) return;
              showSnackBar(context, "Event schedule posted successfully");
            }
            if (!mounted) return;
            setState(() {
              isLoading = true;
            });
            Navigator.pushNamedAndRemoveUntil(
                context, ScoreBoardHome.id, (route) => false);
          } on DioError catch (err) {
            showErrorSnackBar(context, err);
            setState(() {
              isLoading = false;
            });
          }
        }
      }
    }

    return Scaffold(
      backgroundColor: Themes.theme.backgroundColor,
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
                      AutocompleteTextField(callbackFunction: callbackAutocomplete, standings: widget.event?.event,),
                      const SizedBox(height: 12),
                      CustomDropDown(
                        items: moduleNames,
                        hintText: 'Module',
                        onChanged: (s) {
                          module = s;
                          // setState(() {
                          //   hostelsSize = 0;
                          //   participatingHostels = [];
                          //   hostelSizeValue = null;
                          // });
                        },
                        value: module,
                        validator: validateField,
                      ),
                      const SizedBox(height: 12),
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
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
