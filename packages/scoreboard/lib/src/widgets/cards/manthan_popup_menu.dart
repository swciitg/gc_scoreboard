import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../functions/snackbar.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../models/manthan_models/manthan_event_model.dart';
import '../../screens/home.dart';
import '../../screens/manthan/forms/add_manthan_event_form.dart';
import '../../screens/manthan/forms/manthan_result_form.dart';
import '../../screens/sahyog/forms/add_sahyog_event_form.dart';
import '../../screens/sahyog/forms/sahyog_result_form.dart';
import '../../services/api.dart';
import '../../stores/common_store.dart';

class ManthanPopupMenu extends StatefulWidget {
  final Widget child;
  final List<PopupMenuEntry> items;
  final eventModel;
  const ManthanPopupMenu(
      {Key? key,
        required this.child,
        required this.items,
        required this.eventModel})
      : super(key: key);

  @override
  State<ManthanPopupMenu> createState() => _ManthanPopupMenuState();
}

class _ManthanPopupMenuState extends State<ManthanPopupMenu> {
  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails tapDownDetails) {
    _tapPosition = tapDownDetails.globalPosition;
  }

  void _showContextMenu(context, commonStore) async {
    if (widget.items.isEmpty) {
      return;
    }
    bool isManthan = (widget.eventModel.runtimeType == ManthanEventModel);

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
                builder: (context) => isManthan
                    ? AddManthanEventForm(
                  event: widget.eventModel,
                )
                    : AddSahyogEventForm(
                  event: widget.eventModel,
                )));
        break;

      case 'edit result':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => isManthan
                    ? ManthanResultForm(
                  event: widget.eventModel,
                )
                    : SahyogResultForm(event: widget.eventModel)));
        break;
      case 'add':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => isManthan
                    ? ManthanResultForm(
                  event: widget.eventModel,
                )
                    : SahyogResultForm(event: widget.eventModel)));
        break;
      case 'delete':
        try {
          if (commonStore.page == Pages.results) {
            if (isManthan) {
              await APIService(context)
                  .deleteManthanEventResult(widget.eventModel.id!);
            } else {
              await APIService(context).deleteSahyogEventResult(widget.eventModel.id!);
            }
            showSnackBar(context, "Result Deleted");
          } else {
            if (isManthan) {
              await APIService(context).deleteManthanEvent(widget.eventModel.id!);
            } else {
              await APIService(context).deleteSahyogEvent(widget.eventModel.id!);
            }
            showSnackBar(context, "Event Deleted");
          }
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ScoreBoardHome()));
        } on DioError catch (err) {
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
