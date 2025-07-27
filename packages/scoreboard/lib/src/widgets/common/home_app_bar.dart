import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../functions/snackbar.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../globals/styles.dart';
import '../../screens/home.dart';
import '../../stores/common_store.dart';

class AppBarHomeComponent extends StatefulWidget {
  const AppBarHomeComponent({super.key});

  @override
  State<AppBarHomeComponent> createState() => _AppBarHomeComponentState();
}

class _AppBarHomeComponentState extends State<AppBarHomeComponent> {
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
                  Navigator.of(context, rootNavigator: true).pop();
                  // Navigator.popUntil(context, ModalRoute.withName("/home2"));
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
                            value: commonStore.viewType.toString(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 11),
                            child: Text(
                              commonStore.viewType == ViewType.admin
                                  ? "Switch to User View"
                                  : "Switch to Admin View",
                              style: headline6,
                            )),
                      ],
                      onSelected: (value) async {
                        if (value==ViewType.user.toString()) {
                          if (!commonStore.isAdmin) {
                            showSnackBar(context, "You are not an admin");
                            return;
                          }
                          commonStore.setViewType(ViewType.admin);
                        } else {
                          commonStore.setViewType(ViewType.user);
                        }
                        Navigator.pushNamedAndRemoveUntil(
                            context, ScoreBoardHome.id, (route) => false); // to change screens data
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
