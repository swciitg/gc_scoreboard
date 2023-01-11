import 'package:flutter/material.dart';
import '../../globals/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? value;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function()? onTap;
  final onChanged;
  final bool isNecessary;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.validator,
      this.controller,
      required this.isNecessary,
      this.onTap,
      this.onChanged,
      this.value});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final text = widget.value?.toString() == 'null' ? '' : widget.value?.toString();
    final controller =(widget.controller==null)?TextEditingController(text: text):widget.controller;
    return TextFormField(
      readOnly: widget.onTap != null,
      style: Themes.theme.textTheme.headline6?.copyWith(color: Colors.white),
      validator: widget.validator,
      controller: controller,
      cursorColor: Themes.theme.primaryColor,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.hintText,
                style: Themes.theme.textTheme.bodyText1,
              ),
              if(widget.isNecessary)
              TextSpan(
                text: ' * ',
                style: Themes.theme.textTheme.headline5,
              ),
            ],
          ),
        ),
        labelStyle: Themes.theme.textTheme.bodyText1,
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
