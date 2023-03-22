import 'package:flutter/material.dart';

import '../../globals/colors.dart';
import '../../stores/static_store.dart';
import '../add_result/custom_text_field.dart';


class AutocompleteTextField extends StatefulWidget {
  final Function callbackFunction;
  final String? standings;
  
  const AutocompleteTextField({super.key, required this.callbackFunction, this.standings,});

  @override
  State<AutocompleteTextField> createState() => _AutocompleteTextField();
}

class _AutocompleteTextField extends State<AutocompleteTextField> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
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
      TextEditingValue(text: widget.standings ?? ""),
      onSelected: (s) => widget.callbackFunction(s),
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
          focusNode: f, isNecessary: true,
        );
      },
    );
  }
}