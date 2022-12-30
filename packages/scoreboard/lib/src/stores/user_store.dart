import 'package:flutter/cupertino.dart';
import 'package:scoreboard/src/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoreboard/src/functions/auth_user_helper.dart';

class UserStore{
  Map<String,String> userData={};
  static List<String> spardhaEvents=[];

  Future<bool> saveUserData(Map<String,String> userInfo,BuildContext buildContext) async {
    print(userInfo);
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey("accessToken")){ // has already once used scoreboard
      userData["name"] = userInfo["name"]!;
      userData["email"] = userInfo["email"]!;
      await AuthUserHelpers.setUserData(userInfo);
      await APIService(buildContext).generateTokens();
    }
    spardhaEvents= await APIService(buildContext).getAllSpardhaEvents();
    print(spardhaEvents.toString());
    return true;
  }



}