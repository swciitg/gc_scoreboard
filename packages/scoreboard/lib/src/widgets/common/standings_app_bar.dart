import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../globals/styles.dart';
import '../../screens/home.dart';
import '../../stores/common_store.dart';

class StandingsAppBar extends StatefulWidget {
  const StandingsAppBar({Key? key}) : super(key: key);

  @override
  State<StandingsAppBar> createState() => _StandingsAppBarState();
}

class _StandingsAppBarState extends State<StandingsAppBar> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Container(
      color: Themes.secondaryColor,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 80,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Themes.cardColor1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_back_outlined,
                        size: 16,
                        color: Themes.primaryColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('One', style: cardStageStyle2),
                      Text('.', style: cardStageStyle1),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Text('Scoreboard', style: headingStyle1),
                  Text('.', style: headingStyle2),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                    // width: width * 0.8,
                    width: 72,
                    height: 36,
                    alignment: Alignment.centerRight,
                    child: PopupMenuButton<String>(
                      padding: const EdgeInsets.only(top: 4),
                      icon: const Icon(Icons.more_vert, color: Themes.kWhite),
                      color: Themes.kGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      itemBuilder: (BuildContext buildContext) => [
                        PopupMenuItem(
                            value: ScoreBoardHome.id,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 11),
                            child: Text(
                              "Switch to User View",
                              style: Themes.theme.textTheme.headline6,
                            )),
                      ],
                      onSelected: (newRoute) async {
                        commonStore.setViewType(ViewType.user);
                        Navigator.pushNamedAndRemoveUntil(
                            context, ScoreBoardHome.id, (route) => false);
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
