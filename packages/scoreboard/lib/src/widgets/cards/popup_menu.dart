import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import '../../models/event_model.dart';
import '../../models/result_model.dart';
import '../../screens/add_event_form.dart';
import '../../screens/add_result_form.dart';

class PopupMenu extends StatefulWidget {
  final Widget child;
  final List<PopupMenuEntry> items;
  final EventModel eventModel;
  const PopupMenu(
      {Key? key,
      required this.child,
      required this.items,
      required this.eventModel})
      : super(key: key);

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails tapDownDetails) {
    _tapPosition = tapDownDetails.globalPosition;
  }

  void _showContextMenu(context) async {
    final RenderBox overlay =
        Overlay.of(context)?.context.findRenderObject() as RenderBox;

    final result = await showMenu(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Themes.kGrey,
        context: context,
        position: RelativeRect.fromSize(
            _tapPosition & const Size(0, 0), overlay.size),
        items: widget.items);

    switch (result) {
      case 'edit schedule':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEventForm(
                      event: widget.eventModel,
                    )));
        break;

      case 'edit result':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddResultForm(
                      event: widget.eventModel,
                    )));
        break;
      case 'add':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddResultForm(
                      event: widget.eventModel,
                    )));
        break;
      case 'delete':
        print(result);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Container()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (position) {
        _getTapPosition(position);
      },
      onLongPress: () {
        _showContextMenu(context);
      },
      child: widget.child,
    );
  }
}
