import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../functions/snackbar.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../models/kriti_models/kriti_event_model.dart';
import '../../models/manthan_models/manthan_event_model.dart';
import '../../models/sahyog_models/sahyog_event_model.dart';
import '../../screens/home.dart';
import '../../screens/kriti/forms/add_kriti_event_form.dart';
import '../../screens/kriti/forms/kriti_result_form.dart';
import '../../screens/manthan/forms/add_manthan_event_form.dart';
import '../../screens/manthan/forms/manthan_result_form.dart';
import '../../screens/sahyog/forms/add_sahyog_event_form.dart';
import '../../screens/sahyog/forms/sahyog_result_form.dart';
import '../../screens/spardha/forms/add_event_form.dart';
import '../../screens/spardha/forms/add_result_form.dart';
import '../../services/api.dart';
import '../../stores/common_store.dart';

class PopupMenu extends StatefulWidget {
  final Widget child;
  final List<PopupMenuEntry> items;
  final eventModel;
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
  String competition = "spardha";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      var type = widget.eventModel.runtimeType;
      (type == KritiEventModel)
          ? competition = "kriti"
          : (type == SahyogEventModel)
          ? competition ="sahyog"
          : (type == ManthanEventModel)
          ? competition ="manthan"
          : competition = "spardha";
    });

  }

  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails tapDownDetails) {
    _tapPosition = tapDownDetails.globalPosition;
  }

  void _showContextMenu(context, commonStore) async {
    if (widget.items.isEmpty) {
      return;
    }

    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

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
                builder: (context){
                  switch(competition)
                      {
                    case 'spardha':
                      return SpardhaEventForm(event: widget.eventModel,);
                    case 'manthan':
                      return ManthanEventForm(event: widget.eventModel,);
                    case 'kriti':
                      return KritiEventForm(event: widget.eventModel,);
                    case 'sahyog':
                      return SahyogEventForm(event: widget.eventModel,);
                  }
                  return const Scaffold();
                }
            ));
        break;

      case 'edit result':
      case 'add':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context){
                  switch(competition)
                  {
                    case 'spardha':
                      return SpardhaResultForm(event: widget.eventModel,);
                    case 'manthan':
                      return ManthanResultForm(event: widget.eventModel,);
                    case 'kriti':
                      return KritiResultForm(event: widget.eventModel,);
                    case 'sahyog':
                      return SahyogResultForm(event: widget.eventModel,);
                  }
                  return const Scaffold();
                }
            ));
        break;
      case 'delete':
        try {
          if (commonStore.page == Pages.results) {
            await APIService(context).deleteResult(eventID: widget.eventModel.id!, competition: competition);
            showSnackBar(context, "Result Deleted");
          } else {
            await APIService(context).deleteEvent(eventID: widget.eventModel.id!, competition: competition);
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
