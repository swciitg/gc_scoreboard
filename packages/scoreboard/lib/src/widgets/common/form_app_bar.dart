import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';

class AppBarFormComponent extends StatefulWidget {
  final String title;
  final String actionTitle;
  final Function onFormSubmit;
  const AppBarFormComponent(
      {super.key,
      required this.title,
      required this.actionTitle,
      required this.onFormSubmit});

  @override
  State<AppBarFormComponent> createState() => _AppBarFormComponentState();
}

class _AppBarFormComponentState extends State<AppBarFormComponent> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Themes.backgroundColor,
      shape: const Border(
        bottom: BorderSide(
          color: Themes.dividerColor1,
          width: 1,
        ),
      ),
      centerTitle: true,
      title: Text(
        widget.title,
        style: headline2,
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.close,
          color: Themes.primaryColor,
        ),
        splashColor: Themes.splashColor,
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await widget.onFormSubmit();
          },
          child: Text(
            widget.actionTitle,
            style: headline3,
          ),
        )
      ],
    );
  }
}
