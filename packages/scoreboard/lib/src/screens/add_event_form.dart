import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoreboard/src/functions/schedule_event/validator.dart';
import 'package:scoreboard/src/models/event_model.dart';

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
  final TextEditingController _sportNameController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController timeInput = TextEditingController();
  String? category;
  String? stage;
  String? group;

  final List<String> sports = [
    'Athletics',
    'Swimming',
    'Basketball',
    'Football',
    'Badminton',
    'Aquatics'
  ];

  final List<String?> participatingHostels = [];

  bool isPostponed = false, isCancelled = false;
  int hostels = 0;

  callbackHostels(value) {
    participatingHostels.length = int.parse(value);
    setState(() {
      hostels = int.parse(value);
    });
  }

  callbackAddHostel(value,index) {
    participatingHostels[index - 1] = value;
  }

  @override
  void initState() {
    super.initState();
    if (widget.event != null ) {
      EventModel e = widget.event!;
      _sportNameController.text = e.name;
      _venueController.text = e.venue;
      group = e.group;
      category = e.category;
      stage = e.stage;
    }
  }
  @override
  Widget build(BuildContext context) {
    print("Rebuild");
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
          widget.event == null ? 'Add Event' : 'Edit Event',
          style: Themes.theme.textTheme.headline2,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: Themes.theme.primaryColor,
          ),
          splashColor: const Color.fromRGBO(118, 172, 255, 0.9),
        ),
        actions: [
          TextButton(
            onPressed: () {
              print(group);
            },
            child: Text(
              'Next',
              style: Themes.theme.textTheme.headline3,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Fields marked with',
                        style: Themes.theme.textTheme.headline4,
                      ),
                      TextSpan(
                        text: ' * ',
                        style: Themes.theme.textTheme.headline5,
                      ),
                      TextSpan(
                        text: 'are compulsory',
                        style: Themes.theme.textTheme.headline4,
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Event Details',
                style: Themes.theme.textTheme.headline1,
              ),
              const SizedBox(
                height: 12,
              ),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                      hintText: 'Sport Name',
                      validator: validateField,
                      controller: _sportNameController),
                  const SizedBox(height: 12),
                  CustomDropDown(items: sports, hintText: 'Sport Group', onChanged: (s) => group =s,value: group,),
                  const SizedBox(height: 12),
                  CustomDropDown(items: sports, hintText: 'Category',onChanged: (s) => category =s, value: category,),
                  const SizedBox(height: 12),
                  CustomDropDown(items: sports, hintText: 'Stage', onChanged: (s) => stage = s, value: stage,),
                  const SizedBox(height: 12),
                  Row(
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
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd-MMM-yyyy').format(pickedDate);
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
                            FocusScope.of(context).requestFocus(FocusNode());
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context, //context of current state
                            );
                            if (pickedTime != null) {
                              if (!mounted) return;
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(pickedTime.format(context).toString());
                              String formattedTime =
                                  DateFormat('h:mm a').format(parsedTime);
                              //DateFormat() is from intl package, you can format the time on any pattern you need.
                              setState(() {
                                timeInput.text =
                                    formattedTime; //set output date to TextField value.
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
                          });
                        },
                      ),
                      Text('Event cancelled',
                          style: Themes.theme.textTheme.headline2),
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Themes.theme.primaryColor,
                        side: const BorderSide(
                            color: Color.fromRGBO(171, 171, 175, 1), width: 2),
                        value: isPostponed,
                        onChanged: (bool? value) {
                          setState(() {
                            isPostponed = value!;
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
                    hintText: 'Select Number of Hostels',
                    onChanged: callbackHostels,
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
                              items: sports,
                              hintText: 'Hostel Name $i',
                              index: i,
                              onChanged: callbackAddHostel),
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
