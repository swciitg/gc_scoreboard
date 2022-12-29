import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoreboard/src/functions/schedule_event/validator.dart';
import 'package:scoreboard/src/globals/global_widgets.dart';
import 'package:scoreboard/src/globals/helper_variables.dart';
import 'package:scoreboard/src/models/event_model.dart';
import 'package:scoreboard/src/screens/confirm_event_details.dart';
import 'package:scoreboard/src/stores/user_store.dart';
import 'package:scoreboard/src/widgets/add_event/heading.dart';
import 'package:scoreboard/src/widgets/common/app_bar.dart';
import '../globals/constants.dart';
import '../globals/themes.dart';
import '../widgets/add_event/drop_down.dart';
import '../widgets/add_event/text_field.dart';

class AddEventForm extends StatefulWidget {
  final EventModel? event;
  const AddEventForm({super.key, this.event});

  @override
  State<AddEventForm> createState() => _AddEventFormState();
}

class _AddEventFormState extends State<AddEventForm> {
  String? sportName;
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController timeInput = TextEditingController();
  DateTime? selectedDate; // stores date picked
  TimeOfDay? selectedTime; // stores time picked
  bool isPostponed = false;
  bool isCancelled = false;
  String? category;
  String? stage;
  int hostels = 0;
  List<String?> participatingHostels = [];
  final _formKey = GlobalKey<FormState>();

  callbackHostels(value) {
    participatingHostels.length = int.parse(value);
    setState(() {
      hostels = int.parse(value);
    });
  }

  callbackAddHostel(value, index) {
    participatingHostels[index - 1] = value;
  }

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      EventModel e = widget.event!;
      sportName = e.event;
      _venueController.text = e.venue;
      category = e.category;
      stage = e.stage;
      hostels = e.hostels.length;
      for (var hostel in e.hostels) {
        participatingHostels.add(hostel);
      }
      if (e.status == 'cancelled') {
        isCancelled = true;
      } else if (e.status == 'postponed') {
        isPostponed = true;
      }
      dateInput.text = DateFormat('dd-MMM-yyyy').format(e.date);
      timeInput.text = DateFormat('h:mm a').format(e.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> onFormSubmit() async {
      if (!_formKey.currentState!.validate()) {
        showSnackBar(context, 'Please give all the inputs correctly');
        return;
      } else {
        DateTime eventDateTime = DateTime(
            selectedDate!.year,
            selectedDate!.month,
            selectedDate!.day,
            selectedTime!.hour,
            selectedTime!.minute);

        var data = {
          "event": sportName,
          "category": category!,
          "stage": stage!,
          "date": eventDateTime.toIso8601String(),
          "venue": _venueController.text,
          "hostels": participatingHostels,
          "status": isCancelled
              ? 'cancelled'
              : isPostponed
                  ? 'postponed'
                  : 'ok',
          "results": [],
          "resultAdded": false
        };
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ConfirmEventDetails(
                  event: EventModel.fromJson(data),
                )));
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
                      CustomDropDown(
                        items: UserStore.spardhaEvents,
                        hintText: 'Event Name',
                        onChanged: (s) => sportName = s,
                        value: sportName,
                        validator: validateField,
                      ),
                      const SizedBox(height: 12),
                      CustomDropDown(
                        items: eventCategories,
                        hintText: 'Category',
                        onChanged: (s) => category = s,
                        value: category,
                        validator: validateField,
                      ),
                      const SizedBox(height: 12),
                      CustomDropDown(
                        items: spardhaEventStages,
                        hintText: 'Stage',
                        onChanged: (s) => stage = s,
                        value: stage,
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
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));
                                if (pickedDate != null) {
                                  if (!mounted) return;
                                  selectedDate = pickedDate;
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
                                    return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: false),
                                        // If you want 24-Hour format, just change alwaysUse24HourFormat to true or remove all the builder argument
                                        child: childWidget!);
                                  },
                                  initialTime: TimeOfDay.now(),
                                  context: context, //context of current state
                                );
                                if (pickedTime != null) {
                                  if (!mounted) return;
                                  selectedTime = pickedTime;
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
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Themes.theme.primaryColor,
                            side: const BorderSide(
                              color: Color.fromRGBO(171, 171, 175, 1),
                              width: 2,
                            ),
                            value: isCancelled,
                            onChanged: (bool? value) {
                              setState(() {
                                isCancelled = value!;
                                isPostponed = false;
                              });
                            },
                          ),
                          Text('Event cancelled',
                              style: Themes.theme.textTheme.headline2),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Themes.theme.primaryColor,
                            side: const BorderSide(
                                color: Color.fromRGBO(171, 171, 175, 1),
                                width: 2),
                            value: isPostponed,
                            onChanged: (bool? value) {
                              setState(() {
                                isPostponed = value!;
                                isCancelled = false;
                              });
                            },
                          ),
                          Text('Event postponed',
                              style: Themes.theme.textTheme.headline2),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Participating Hostels',
                        style: Themes.theme.textTheme.headline1,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      CustomDropDown(
                        items: [for (var i = 1; i <= 10; i++) i.toString()],
                        value: (widget.event != null)
                            ? widget.event!.hostels.length.toString()
                            : null,
                        hintText: 'Select Number of Hostels',
                        onChanged: callbackHostels,
                        validator: validateField,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Column(
                        children: [
                          for (var i = 1; i <= hostels; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: CustomDropDown(
                                items: allHostelList,
                                value: participatingHostels[i - 1],
                                hintText: 'Hostel Name $i',
                                index: i,
                                validator: validateField,
                                onChanged: callbackAddHostel,
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
