import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../functions/snackbar.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../models/standing_model.dart';
import '../../screens/spardha/added_standings.dart';
import '../../screens/spardha/forms/add_standing_form.dart';
import '../../services/api.dart';
import '../../stores/common_store.dart';

class StandingPopup extends StatefulWidget {
  final Widget child;
  final List<PopupMenuEntry> items;
  final StandingModel standingModel;
  const StandingPopup(
      {super.key,
      required this.child,
      required this.items,
      required this.standingModel});

  @override
  State<StandingPopup> createState() => _StandingPopupState();
}

class _StandingPopupState extends State<StandingPopup> {
  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails tapDownDetails) {
    _tapPosition = tapDownDetails.globalPosition;
  }

  void _showContextMenu(BuildContext context, CommonStore commonStore) async {
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
      case 'edit standings':
      if (!context.mounted) return;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddStanding(
                      standings: widget.standingModel,
                    )));
        break;

      case 'delete':
      if (!context.mounted) return;
        bool response =
            await APIService(context).deleteSpardhaStanding(widget.standingModel.id!);
        commonStore.competition = Competitions.gc;
        if (!response) {
          if (!context.mounted) return;
          showSnackBar(context, 'Some error occurred, try again later');
        } else {
          if (!context.mounted) return;
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
