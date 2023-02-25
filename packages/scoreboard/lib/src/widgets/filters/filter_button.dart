import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';

class FilterButton extends StatefulWidget {
  final String label;
  final String value;
  final List<String> items;
  final Function setFunction;
  const FilterButton(
      {Key? key,
      required this.label,
      required this.value,
      required this.items,
      required this.setFunction})
      : super(key: key);

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
          child: PopupMenuButton(
            constraints: const BoxConstraints(maxHeight: 300),
            position: PopupMenuPosition.under,
            color: Themes.cardColor1,
            onSelected: (String item) {
              widget.setFunction(item);
            },
            itemBuilder: (BuildContext context) => widget.items
                .map((item) => PopupMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: popUpItemStyle,
                      ),
                    ))
                .toList(),
            child: Container(
              height: 56,
              decoration: boxDecoration,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 12,
                          child: Text(widget.label, style: popUpHeadingStyle),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 18,
                          child: Text(widget.value, style: popUpItemStyle),
                        )
                      ],
                    ),
                    popUpIcon,
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
