import 'package:flutter/cupertino.dart';
import 'package:scoreboard/src/stores/user_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals/constants.dart';
import '../services/api.dart';

class AuthUserHelpers{

  static Future<bool> checkIfAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(DatabaseRecords.isadmin) ?? false;
  }

  static Future<void> setAdmin(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(DatabaseRecords.isadmin,value);
  }

  static Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DatabaseRecords.accesstoken) ?? " ";
  }

  static Future<void> setAccessToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(DatabaseRecords.accesstoken, value);
  }

  static Future<String> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DatabaseRecords.refreshtoken) ?? " ";
  }

  static Future<void> setRefreshToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(DatabaseRecords.refreshtoken, value);
  }

  static Future<Map<String,String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {"name" : prefs.getString(DatabaseRecords.username) ?? " ",DatabaseRecords.useremail : prefs.getString(DatabaseRecords.useremail) ?? " "};
  }

  static Future<void> setAuthEvents(Map<String,bool> value) async {
    print(value.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(DatabaseRecords.authevents, value.toString());
  }


  static Future<bool> saveUserData(Map<String,String> userInfo,BuildContext buildContext) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", userInfo["email"]!);
    await prefs.setString("name", userInfo["name"]!);
    if(!prefs.containsKey("accessToken")){ // has already once used scoreboard
      await APIService(buildContext).generateTokens();
    }
    SpardhaStore.spardhaEvents= await APIService(buildContext).getAllSpardhaEvents();
    print(SpardhaStore.spardhaEvents);
    return true;
  }

}