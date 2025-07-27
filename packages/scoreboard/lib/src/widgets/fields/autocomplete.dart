import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/globals/enums.dart';
import 'package:scoreboard/src/globals/styles.dart';
import 'package:scoreboard/src/stores/common_store.dart';

import '../../globals/colors.dart';
import '../../stores/static_store.dart';
import 'custom_text_field.dart';

class AutocompleteTextField extends StatefulWidget {
  final Function callbackFunction;
  final String? standings;

  const AutocompleteTextField({
    super.key,
    required this.callbackFunction,
    this.standings,
  });

  @override
  State<AutocompleteTextField> createState() => _AutocompleteTextField();
}

class _AutocompleteTextField extends State<AutocompleteTextField> {
  @override
  Widget build(BuildContext context) {
    final commonStore = context.read<CommonStore>();
    final events = commonStore.competition == Competitions.spardha
        ? StaticStore.spardhaEvents
        : commonStore.competition == Competitions.kriti
            ? StaticStore.kritiEvents
            : commonStore.competition == Competitions.manthan
                ? StaticStore.manthanEvents
                : commonStore.competition == Competitions.sahyog
                    ? StaticStore.sahyogEvents
                    : <String>[];

    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue val) {
        if (val.text == '') {
          return const Iterable<String>.empty();
        }
        return events.where((element) =>
            element.toLowerCase().contains(val.text.toLowerCase()));
      },
      initialValue: TextEditingValue(text: widget.standings ?? ""),
      onSelected: (s) => widget.callbackFunction(s),
      optionsMaxHeight: 50,
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        // options = [...options,...options,...options,...options,...options,...options,...options,];
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: Colors.transparent,
            child: SizedBox(
              height: 250,
              child: ListView.builder(
                // padding: EdgeInsets.all(10.0),
                padding: const EdgeInsets.symmetric(vertical: 0),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      tileColor: Themes.backgroundColor,
                      title: Text(
                        option,
                        style: headline6,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      fieldViewBuilder: (context, c, f, _) {
        return CustomTextField(
          hintText: 'Event Name',
          validator: (s) {
            if (events.contains(s)) {
              return null;
            }
            return "Enter a valid event";
          },
          controller: c,
          focusNode: f,
          isNecessary: true,
        );
      },
    );
  }
}
