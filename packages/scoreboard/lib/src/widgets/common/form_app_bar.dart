import 'package:flutter/material.dart';
import '../../globals/colors.dart';

class AppBarFormComponent extends StatefulWidget {
  final String title;
  final String actionTitle;
  final Function onFormSubmit;
  const AppBarFormComponent(
      {Key? key,
      required this.title,
      required this.actionTitle,
      required this.onFormSubmit})
      : super(key: key);

  @override
  State<AppBarFormComponent> createState() => _AppBarFormComponentState();
}

class _AppBarFormComponentState extends State<AppBarFormComponent> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        widget.title,
        style: Themes.theme.textTheme.headline2,
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.close,
          color: Themes.theme.primaryColor,
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
            style: Themes.theme.textTheme.headline3,
          ),
        )
      ],
    );
  }
}
