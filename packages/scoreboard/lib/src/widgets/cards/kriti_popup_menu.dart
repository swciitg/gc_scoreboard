import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/screens/kriti/forms/add_kriti_event_form.dart';
import 'package:scoreboard/src/services/api.dart';

import '../../functions/snackbar.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../models/kriti_models/kriti_event_model.dart';
import '../../screens/home.dart';
import '../../screens/kriti/forms/kriti_result_form.dart';
import '../../stores/common_store.dart';


class KritiPopupMenu extends StatefulWidget {
  final Widget child;
  final List<PopupMenuEntry> items;
  final KritiEventModel eventModel;
  const KritiPopupMenu(
      {Key? key,
        required this.child,
        required this.items,
        required this.eventModel})
      : super(key: key);

  @override
  State<KritiPopupMenu> createState() => _KritiPopupMenuState();
}

class _KritiPopupMenuState extends State<KritiPopupMenu> {
  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails tapDownDetails) {
    _tapPosition = tapDownDetails.globalPosition;
  }

  void _showContextMenu(context, commonStore) async {

    if (widget.items.isEmpty) {
      return;
    }
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
                builder: (context) => AddKritiEventForm(
                  event: widget.eventModel,
                )));
        break;

      case 'edit result':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => KritiResultForm(
                  event: widget.eventModel,
                )));
        break;
      case 'add':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => KritiResultForm(
                  event: widget.eventModel,
                )));
        break;
      case 'delete':
        try{
          if(commonStore.page == Pages.results){
            await APIService(context).deleteKritiEventResult(widget.eventModel.id!);
            showSnackBar(context,"Result Deleted");
          }
          else{
            await APIService(context).deleteKritiEvent(widget.eventModel.id!);
            showSnackBar(context,"Event Deleted");
          }
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ScoreBoardHome()));
        }
        on DioError catch(err){
          showErrorSnackBar(context, err);
        }
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