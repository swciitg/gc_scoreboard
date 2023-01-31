import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final String? value;
  final void Function(String)? onChanged;
  final bool isNecessary;
  final TextEditingController? controller;
  final void Function()? onTap;
  final FocusNode? focusNode;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.validator,
      this.value,
      this.onChanged,
      required this.isNecessary,
      this.inputType,
      this.controller,
      this.onTap,
      this.focusNode});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.onTap != null,
      style: Themes.theme.textTheme.headline6?.copyWith(color: Colors.white),
      validator: widget.validator,
      controller: widget.controller,
      focusNode: widget.focusNode,
      cursorColor: Themes.theme.primaryColor,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      initialValue: widget.value == 'null' ? '' : widget.value,
      keyboardType: widget.inputType,
      decoration: InputDecoration(
        errorStyle: basicFontStyle,
        label: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.hintText,
                style: Themes.theme.textTheme.bodyText1,
              ),
              if (widget.isNecessary)
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
