import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../globals/colors.dart';

class CustomTextFieldTwo extends StatelessWidget {
  final String hintText;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final String? value;
  final void Function(String)? onChanged;
  final bool isNecessary;

  const CustomTextFieldTwo(
      {super.key,
      required this.hintText,
      required this.validator,
      required this.value,
      required this.onChanged,
      required this.isNecessary, required this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Themes.theme.textTheme.headline6,
      validator: validator,
      onChanged: onChanged,
      initialValue: value=='null' ? '' : value,
      cursorColor: Themes.theme.primaryColor,
      keyboardType: inputType,
      decoration: InputDecoration(
        errorStyle: GoogleFonts.montserrat(),
        label: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: hintText,
                style: Themes.theme.textTheme.bodyText1,
              ),
              if (isNecessary)
                TextSpan(
                  text: ' * ',
                  style: Themes.theme.textTheme.headline5,
                ),
            ],
          ),
        ),
        labelStyle: Themes.theme.textTheme.bodyText1,
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
