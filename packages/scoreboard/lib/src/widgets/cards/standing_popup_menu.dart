import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/screens/spardha/add_standing.dart';
import '../../functions/snackbar.dart';
import '../../globals/colors.dart';
import '../../models/standing_model.dart';
import '../../screens/spardha/added_standings.dart';
import '../../services/api.dart';
import '../../stores/common_store.dart';

class StandingPopup extends StatefulWidget {
  final Widget child;
  final List<PopupMenuEntry> items;
  final StandingModel standingModel;
  const StandingPopup(
      {Key? key,
      required this.child,
      required this.items,
      required this.standingModel})
      : super(key: key);

  @override
  State<StandingPopup> createState() => _StandingPopupState();
}

class _StandingPopupState extends State<StandingPopup> {
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
      case 'edit standings':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddStanding(standings: widget.standingModel,)));
        break;

      case 'delete':
        bool response =
            await APIService(context).deleteStanding(widget.standingModel.id!);

        if (!response) {
          showSnackBar(context, 'Some error occured, try again later');
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const SpardhaAdminStandingsPage()));
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
