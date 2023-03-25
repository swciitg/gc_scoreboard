import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final Function? onChanged;
  final String? Function(String?)? validator;
  final int? index;
  final String? value;

  const CustomDropDown(
      {super.key,
      required this.items,
      required this.hintText,
      required this.onChanged,
      this.index,
      this.value,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: validator,
      menuMaxHeight: 400,
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: hintText,
                style: bodyText1,
              ),
              TextSpan(
                text: ' * ',
                style: headline5,
              ),
            ],
          ),
        ),
        labelStyle: bodyText1,
        errorStyle: basicFontStyle,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Themes.focusColor, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Themes.focusColor, width: 1),
          borderRadius: BorderRadius.all(
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
      dropdownColor: Themes.backgroundColor,
      isDense: true,
      icon: const Icon(
        Icons.arrow_drop_down,
        size: 28,
      ),
      elevation: 16,
      style: headline6,
      onChanged: (String? value) {
        if (index != null) {
          onChanged!(value, index);
        } else {
          onChanged!(value);
        }
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
