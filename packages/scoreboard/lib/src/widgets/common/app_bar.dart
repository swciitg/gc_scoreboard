import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/globals/auth_user_helper.dart';
import 'package:scoreboard/src/globals/global_widgets.dart';
import 'package:scoreboard/src/globals/helper_variables.dart';
import 'package:scoreboard/src/screens/home.dart';
import 'package:scoreboard/src/screens/login/admin_login.dart';
import 'package:scoreboard/src/stores/common_store.dart';
import '../../globals/themes.dart';

class AppBarHomeComponent extends StatefulWidget {
  ViewType homeViewType;
  AppBarHomeComponent({Key? key,required this.homeViewType}) : super(key: key);

  @override
  State<AppBarHomeComponent> createState() => _AppBarHomeComponentState();
}

class _AppBarHomeComponentState extends State<AppBarHomeComponent> {
  @override
  Widget build(BuildContext context) {
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
                  Navigator.of(context).popUntil((route) => false);
                },
                child: Container(
                  width: 80,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Themes.cardColor1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_outlined,
                        size: 16,
                        color: Themes.primaryColor,
                      ),
                      SizedBox(
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
                      padding: EdgeInsets.only(top: 4),
                      icon: Icon(Icons.more_vert, color: Themes.kWhite),
                      color: Themes.kGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      itemBuilder: (BuildContext buildContext) => [
                        PopupMenuItem(
                            value: widget.homeViewType== ViewType.user
                                ? LoginView.id
                                : ScoreBoardHome.id,
                            padding: EdgeInsets.symmetric(
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
                              .contains(connectivityResult) &&
                              await Navigator.pushNamed(
                                  context, LoginView.id) ==
                                  true) {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (buildContext) => ScoreBoardHome()), (route) => false);
                          }
                        } else
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (buildContext) => ScoreBoardHome()), (route) => false);
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

class AppBarFormComponent extends StatefulWidget {
  String title;
  String actionTitle;
  Function onFormSubmit;
  AppBarFormComponent({Key? key,required this.title,required this.actionTitle,required this.onFormSubmit}) : super(key: key);

  @override
  State<AppBarFormComponent> createState() => _AppBarFormComponentState();
}

class _AppBarFormComponentState extends State<AppBarFormComponent> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Themes.theme.backgroundColor,
      shape: Border(
        bottom: BorderSide(
          color: Themes.theme.dividerColor,
          width: 1,
        ),
      ),
      centerTitle: true,
      title: Text(
        widget.title,
        style: Themes.theme.textTheme.headline2,
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.close,
          color: Themes.theme.primaryColor,
        ),
        splashColor: const Color.fromRGBO(118, 172, 255, 0.9),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await widget.onFormSubmit();
          },
          child: Text(
            widget.actionTitle,
            style: Themes.theme.textTheme.headline3,
          ),
        )
      ],
    );
  }
}


