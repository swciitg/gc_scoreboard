import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../../functions/snackbar.dart';
import '../../../functions/validator.dart';
import '../../../globals/constants.dart';
import '../../../globals/colors.dart';
import '../../../models/kriti_models/kriti_event_model.dart';
import '../../../models/manthan_models/manthan_event_model.dart';
import '../../../services/api.dart';
import '../../../stores/static_store.dart';
import '../../../widgets/add_event/datepicker_color.dart';
import '../../../widgets/add_event/drop_down.dart';
import '../../../widgets/add_event/heading.dart';
import '../../../widgets/add_event/timepicker_color.dart';
import '../../../widgets/add_result/custom_text_field.dart';
import '../../../widgets/common/form_app_bar.dart';
import '../../home.dart';
// import 'confirm_event_details.dart';

class AddManthanEventForm extends StatefulWidget {
  final ManthanEventModel? event;

  const AddManthanEventForm({super.key, this.event});

  @override
  State<AddManthanEventForm> createState() => _AddManthanEventFormState();
}

class _AddManthanEventFormState extends State<AddManthanEventForm> {
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
              await APIService(context)
                  .updateManthanEvent(ManthanEventModel.fromJson(data));
              if (!mounted) return;
              showSnackBar(context, "Event Edited successfully");
            } else {
              await APIService(context).postManthanEventSchedule(data);
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
                      Autocomplete<String>(
                        optionsBuilder: (TextEditingValue val) {
                          if (val.text == '') {
                            return const Iterable<String>.empty();
                          }
                          return StaticStore.manthanEvents.where((element) =>
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
                              if (StaticStore.manthanEvents.contains(s)) {
                                return null;
                              }
                              return "Enter a valid event";
                            },
                            controller: c,
                            focusNode: f,
                            isNecessary: true,
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      CustomDropDown(
                        items: eventCategories,
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