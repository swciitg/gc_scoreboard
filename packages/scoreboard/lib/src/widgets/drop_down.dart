import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/models/nullable_result_model.dart';
import 'package:scoreboard/src/stores/counter.dart';
import '../globals/themes.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> _hostels = [
    'Barak',
    'Brahmaputra',
    'Dhansiri',
    'Dibang',
    'Dihing',
    'Disang',
    'Kameng',
    'Kapili',
    'Lohit',
    'Manas',
    'Married Scholars',
    'Siang',
    'Subansiri',
    'Umiam'
  ];
  final onChanged;
  final value;

   CustomDropDown({super.key, required this.onChanged, required this.value}){
     print("dropdown key is ${super.key}");
   }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      menuMaxHeight: 400,
      hint: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Hostels',
              style: Themes.theme.textTheme.bodyText1,
            ),
            TextSpan(
              text: ' * ',
              style: Themes.theme.textTheme.headline5,
            ),
          ],
        ),
      ),
      isExpanded: true,
      decoration: InputDecoration(
        hintStyle: Themes.theme.textTheme.bodyText1,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Themes.theme.focusColor, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Themes.theme.focusColor, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
      ),
      dropdownColor: Themes.theme.backgroundColor,
      isDense: true,
      icon: const Icon(
        Icons.arrow_drop_down,
        size: 28,
      ),
      elevation: 16,
      style: Themes.theme.textTheme.headline6,
      onChanged: onChanged,
      value: value,
      items: _hostels.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
