import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/stores/static_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals/constants.dart';
import '../services/api.dart';
import '../stores/common_store.dart';

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

  static Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DatabaseRecords.useremail) ?? " ";
  }

  static Future<Map<String,String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {"name" : prefs.getString(DatabaseRecords.username) ?? " ",DatabaseRecords.useremail : prefs.getString(DatabaseRecords.useremail) ?? " "};
  }

  static Future<bool> saveUserData(Map<String,String> userInfo,BuildContext buildContext) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", userInfo["email"]!);
    await prefs.setString("name", userInfo["name"]!);
    if(!prefs.containsKey("accessToken")){ // has already once used scoreboard
      await APIService(buildContext).generateTokens(buildContext.read<CommonStore>());
    }
    StaticStore.spardhaEvents= await APIService(buildContext).getAllSpardhaEvents();
    print(StaticStore.spardhaEvents);
    return true;
  }



}