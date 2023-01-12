import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scoreboard/src/widgets/add_event/timepicker_color.dart';
import '../../../functions/snackbar.dart';
import '../../../functions/validator.dart';
import '../../../globals/constants.dart';
import '../../../globals/colors.dart';
import '../../../models/event_model.dart';
import '../../../stores/static_store.dart';
import '../../../widgets/add_event/drop_down.dart';
import '../../../widgets/add_event/heading.dart';
import '../../../widgets/add_event/text_field.dart';
import '../../../widgets/common/form_app_bar.dart';
import 'confirm_event_details.dart';

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
  String? hostelSizeValue;
  int hostelsSize = 0;
  List<String?> participatingHostels = [];
  final _formKey = GlobalKey<FormState>();

  callbackHostels(value) {
    participatingHostels.length = int.parse(value);
    setState(() {
      hostelsSize = int.parse(value);
      hostelSizeValue = hostelsSize.toString();
    });
  }

  callbackAddHostel(value, index) {
    participatingHostels[index - 1] = value;
    hostelSizeValue = participatingHostels.length.toString();
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
      hostelsSize = e.hostels.length;
      for (var hostel in e.hostels) {
        participatingHostels.add(hostel);
      }
      if (e.status == 'cancelled') {
        isCancelled = true;
      } else if (e.status == 'postponed') {
        isPostponed = true;
      }
      hostelSizeValue = participatingHostels.length.toString();
      selectedDate = e.date;
      selectedTime = TimeOfDay(hour: e.date.hour, minute: e.date.minute);
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

        if (widget.event != null) {
          data['_id'] = widget.event!.id;
        }
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ConfirmEventDetails(
                  isEdit: !(widget.event == null),
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
                      Autocomplete<String>(
                        optionsBuilder: (TextEditingValue val) {
                          if (val.text == '') {
                            return Iterable<String>.empty();
                          }
                          return StaticStore.spardhaEvents.where((element) =>
                              element
                                  .toLowerCase()
                                  .contains(val.text.toLowerCase()));
                        },
                        onSelected: (s) => sportName = s,
                        fieldViewBuilder: (context, c, f, __) {
                          return CustomTextField(
                            hintText: 'Event Name',
                            validator: (s) {
                              if (StaticStore.spardhaEvents.contains(s)) {
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
                        items: eventCategories,
                        hintText: 'Category',
                        onChanged: (s) {
                          category = s;
                          setState(() {
                            hostelsSize = 0;
                            participatingHostels = [];
                            hostelSizeValue = null;
                          });
                        },
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
                                    initialDate: selectedDate ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101),
                                    builder: (context, child) => Theme(
                                          data: Theme.of(context).copyWith(
                                            textTheme: TextTheme(
                                              headline4:
                                                  GoogleFonts.montserrat(),
                                              headline5: GoogleFonts
                                                  .montserrat(), // Selected Date landscape
                                              headline6: GoogleFonts
                                                  .montserrat(), // Selected Date portrait
                                              overline: GoogleFonts
                                                  .montserrat(), // Title - SELECT DATE
                                              bodyText1: GoogleFonts
                                                  .montserrat(), // year gridbview picker
                                              bodyText2: GoogleFonts
                                                  .montserrat(), // year gridbview picker
                                              subtitle1: GoogleFonts
                                                  .montserrat(), // input
                                              subtitle2: GoogleFonts
                                                  .montserrat(), // month/year picker
                                              caption: GoogleFonts
                                                  .montserrat(), // days
                                            ),
                                            colorScheme: ColorScheme.dark(
                                              primary: Colors.blueAccent,
                                              onPrimary: Colors.white,
                                              onSurface: Colors.white,
                                              surface: const Color(0xff2B3E5C),
                                            ),
                                            dialogBackgroundColor:
                                                const Color(0xff2B3E5C),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blue, // button
                                                foregroundColor: Colors.white,
                                                elevation: 0,
                                                textStyle: GoogleFonts.montserrat()
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        ));
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
                                    return TimePickerColor(
                                      childWidget: childWidget,
                                    );
                                  },
                                  initialTime: selectedTime ?? TimeOfDay.now(),
                                  context: context,
                                  //context of current state
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
                        items: [for (var i = 2; i <= 10; i++) i.toString()],
                        value: hostelSizeValue,
                        hintText: 'Select Number of Hostels',
                        onChanged: callbackHostels,
                        validator: validateField,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Column(
                        children: [
                          for (var i = 1; i <= hostelsSize; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: CustomDropDown(
                                items: category == "Men"
                                    ? menHostel
                                    : (category == "Women"
                                        ? womenHostel
                                        : allHostelList),
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
