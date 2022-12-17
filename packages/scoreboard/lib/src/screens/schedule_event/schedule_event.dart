import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoreboard/src/functions/schedule_event/validator.dart';
import 'package:scoreboard/src/widgets/schedule_event/drop_down.dart';
import 'package:scoreboard/src/widgets/schedule_event/text_field.dart';
import '../../globals/themes.dart';

class ScheduleEvent extends StatefulWidget {
  const ScheduleEvent({super.key});

  @override
  State<ScheduleEvent> createState() => _ScheduleEventState();
}

class _ScheduleEventState extends State<ScheduleEvent> {
  final TextEditingController _sportName = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController timeInput = TextEditingController();
  final List<String> sports = [
    'Athletics',
    'Swimming',
    'Basketball',
    'Football',
    'Badminton'
  ];
  bool isPostponed = false, isCancelled = false;
  ValueNotifier<int> hostels = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    // hostels = (_numberOfHostels.dropDownValue == null)
    //     ? ValueNotifier(0)
    //     : ValueNotifier(int.parse(_numberOfHostels.dropDownValue!.name));
  }

  @override
  Widget build(BuildContext context) {
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
          'Add Event',
          style: Themes.theme.textTheme.headline2,
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close),
          splashColor: const Color.fromRGBO(118, 172, 255, 0.9),
          splashRadius: 24,
        ),
        actions: [
          TextButton(
            onPressed: () {},
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
                      controller: _sportName),
                  const SizedBox(height: 12),
                  CustomDropDown(items: sports, hintText: 'Sport Group'),
                  const SizedBox(height: 12),
                  CustomDropDown(items: sports, hintText: 'Category'),
                  const SizedBox(height: 12),
                  CustomDropDown(items: sports, hintText: 'Stage'),
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
                          onTap: () async{
                            FocusScope.of(context).requestFocus(FocusNode());
                            TimeOfDay? pickedTime =  await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context, //context of current state
                            );
                            if(pickedTime != null ){
                              if(!mounted) return;
                              DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                              String formattedTime = DateFormat('h:mm a').format(parsedTime);
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
                      controller: _sportName),
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
