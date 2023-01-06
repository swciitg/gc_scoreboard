import 'package:flutter/material.dart';
import 'package:scoreboard/src/functions/validator.dart';
import 'package:scoreboard/src/models/event_model.dart';
import 'package:scoreboard/src/models/result_model.dart';
import 'package:scoreboard/src/services/api.dart';
import 'package:scoreboard/src/stores/result_form_store.dart';

import 'package:scoreboard/src/widgets/add_result/list_view_widget.dart';
import 'package:scoreboard/src/widgets/cards/card_date_widget.dart';
import '../globals/colors.dart';
import '../widgets/add_result/custom_text_field.dart';
import '../widgets/add_result/fields_mandatory.dart';
import 'home.dart';

class AddResultForm extends StatefulWidget {
  final EventModel event;
  const AddResultForm({super.key, required this.event});

  @override
  State<AddResultForm> createState() => _AddResultFormState();
}

class _AddResultFormState extends State<AddResultForm> {

  TextEditingController victoryStatement = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.event.results.isNotEmpty){
      ResultFormStore.resultFields = widget.event.results;
      ResultFormStore.victoryStatement = widget.event.victoryStatement!;
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
            widget.event.results.isEmpty ? 'Add Result' : 'Edit Result',
            style: Themes.theme.textTheme.headline2,
          ),
          leading: IconButton(
            onPressed: () {
              ResultFormStore.clear();
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
                print('button pressed');
                if (key.currentState!.validate()) {
                  print('submit result pressed');
                  bool respose = await APIService(context).addUpdateResult(widget.event.id!, ResultFormStore.resultFields!,ResultFormStore.victoryStatement!);
                  if(respose)
                    {
                      Navigator.of(context).pushNamedAndRemoveUntil(ScoreBoardHome.id, (route) => false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Success')),
                      );
                      ResultFormStore.clear();
                    }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed')),
                      );
                    }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FieldsMandatory(),
              const SizedBox(
                height: 28,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.event.event,
                        style: Themes.theme.textTheme.headline1,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.event.category,
                        style: Themes.theme.textTheme.headline2,
                      ),
                    ],
                  ),
                  const Spacer(),
                  DateWidget(
                    date: widget.event.date,
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Themes.theme.cardColor,
                ),
                child: Text(
                  widget.event.stage,
                  style: Themes.theme.textTheme.headline3,
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              CustomTextField(
                  hintText: 'Victory Statement',
                  validator: validateField,
                  value: ResultFormStore.victoryStatement,
                  onChanged: (p) {
                    ResultFormStore.victoryStatement = p;
                  },
                  isNecessary: true),
              AddResultList(formKey: key, hostels: widget.event.hostels)
            ],
          ),
        ));
  }
}
