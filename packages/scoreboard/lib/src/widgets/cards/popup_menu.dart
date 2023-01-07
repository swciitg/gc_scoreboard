import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/functions/snackbar.dart';
import 'package:scoreboard/src/globals/enums.dart';
import 'package:scoreboard/src/screens/home.dart';
import 'package:scoreboard/src/services/api.dart';
import 'package:scoreboard/src/stores/common_store.dart';
import '../../globals/colors.dart';
import '../../models/event_model.dart';
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

  void _showContextMenu(context, commonStore) async {
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

        if (commonStore.page == Pages.results) {
          bool response = await APIService(context).deleteSpardhaEventResult(widget.eventModel.id!);
          if(!response)
          {
            showSnackBar(context, 'Some error occured, try again later');
          }
          else
          {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ScoreBoardHome()));
          }
        } else {
          bool response = await APIService(context).deleteEvent(widget.eventModel.id!);
          if(!response)
          {
            showSnackBar(context, 'Some error occured, try again later');
          }
          else
            {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ScoreBoardHome()));
            }
        }
        print(widget.eventModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    CommonStore commmonStore = context.read<CommonStore>();
    return GestureDetector(
      onTapDown: (position) {
        _getTapPosition(position);
      },
      onLongPress: () {
        _showContextMenu(context, commmonStore);
      },
      child: widget.child,
    );
  }
}
