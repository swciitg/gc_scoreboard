import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoreboard/src/globals/auth_user_helper.dart';
import 'package:scoreboard/src/globals/global_widgets.dart';
import 'package:scoreboard/src/globals/helper_variables.dart';
import 'package:scoreboard/src/screens/home.dart';
import 'package:scoreboard/src/screens/login/admin_login.dart';
import '../globals/themes.dart';

PreferredSize appBar(BuildContext buildContext, var type) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(56),
    child: Container(
      color: Themes.appbarBackgroundColor,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  Navigator.of(buildContext).popUntil((route) => false);
                },
                child: Container(
                  width: 80,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Themes.cardColor),
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
                              color: Themes.dotColor)),
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
                          color: Themes.dotColor)),
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
                    icon: Icon(Icons.more_vert,color: Themes.kWhite),
                    color: Themes.kGrey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    itemBuilder: (buildContext) => [
                      PopupMenuItem(
                        value: type==viewType.admin ? ScoreBoardHome.id : LoginView.id,
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 11),
                        child: Text(type==viewType.admin ? "Switch to User View" : "Switch to Admin View",style: Themes.theme.textTheme.headline6,)
                      ),
                    ],
                    onSelected: (newRoute) async {
                      if(newRoute == LoginView.id){
                        if(!await AuthUserHelpers.checkIfAdmin()){
                          showSnackBar(buildContext, "You are not an admin");
                          return;
                        }
                        ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
                        if(connectivityResults.contains(connectivityResult) && await Navigator.pushNamed(buildContext, LoginView.id) == true){
                          Navigator.pushNamedAndRemoveUntil(buildContext, ScoreBoardHome.id, (route) => false);
                        }
                      }
                      else Navigator.pushNamedAndRemoveUntil(buildContext, newRoute, (route) => false);
                    },
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}