import 'package:flutter/material.dart';
import '../globals/themes.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final int? value;
  final onChanged;

  CustomTextField({
    required this.hintText,
    required this.validator,
    required this.value,
    required this.onChanged,
  });


  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value?.toString() );
    return TextFormField(
      style: Themes.theme.textTheme.headline6,
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      cursorColor: Themes.theme.primaryColor,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Themes.theme.textTheme.bodyText1,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
    );
  }
}
