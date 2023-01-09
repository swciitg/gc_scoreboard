import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../functions/auth_user_helper.dart';
import '../../functions/snackbar.dart';
import '../../globals/constants.dart';
import '../../globals/colors.dart';
import '../../globals/enums.dart';
import '../../screens/home.dart';
import '../../screens/login/admin_login.dart';
import '../../stores/common_store.dart';

class AppBarHomeComponent extends StatefulWidget {
  ViewType homeViewType;
  AppBarHomeComponent({Key? key, required this.homeViewType}) : super(key: key);

  @override
  State<AppBarHomeComponent> createState() => _AppBarHomeComponentState();
}

class _AppBarHomeComponentState extends State<AppBarHomeComponent> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Container(
      color: Themes.appbarBackgroundColor,
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
                      Text('One',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Themes.primaryColor)),
                      Text('.',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Themes.cardFontColor3)),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Text('Scoreboard',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Themes.primaryColor)),
                  Text('.',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: Themes.cardFontColor3)),
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
                            value: widget.homeViewType == ViewType.user
                                ? LoginView.id
                                : ScoreBoardHome.id,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 11),
                            child: Text(
                              widget.homeViewType == ViewType.admin
                                  ? "Switch to User View"
                                  : "Switch to Admin View",
                              style: Themes.theme.textTheme.headline6,
                            )),
                      ],
                      onSelected: (newRoute) async {
                        if (newRoute == LoginView.id) {
                          if (!await AuthUserHelpers.checkIfAdmin()) {
                            showSnackBar(context, "You are not an admin");
                            return;
                          }
                          ConnectivityResult connectivityResult =
                              await (Connectivity().checkConnectivity());
                          if (connectivityResults
                                  .contains(connectivityResult)) {
                            Navigator.pushNamed(
                                context, LoginView.id);
                          }
                        } else {
                          commonStore.setViewType(ViewType.user);
                        }
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

