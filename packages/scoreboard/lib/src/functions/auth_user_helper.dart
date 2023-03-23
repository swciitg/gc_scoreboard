import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals/constants.dart';
import '../services/api.dart';
import '../stores/common_store.dart';
import '../stores/static_store.dart';

class AuthUserHelpers {
  static Future<bool> checkIfAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(DatabaseRecords.isadmin) ?? false;
  }

  static Future<void> setAdmin(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(DatabaseRecords.isadmin, value);
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

  static Future<Map<String, String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      "name": prefs.getString(DatabaseRecords.username) ?? " ",
      DatabaseRecords.useremail:
          prefs.getString(DatabaseRecords.useremail) ?? " "
    };
  }

  static Future<void> saveAuthCompetitions(Map<String,bool> auth) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> keys = auth.keys.toList();
    List<bool> values = auth.values.toList();
    for(int i=0;i<keys.length;i++){
      if(prefs.containsKey(keys[i])) await prefs.remove(keys[i]);
      await prefs.setBool(keys[i], values[i]);
    }
  }


  static Future<bool> saveUserData(
      Map<String, String> userInfo, BuildContext buildContext) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", userInfo["email"]!);
      await prefs.setString("name", userInfo["name"]!);
      var commStore = buildContext.read<CommonStore>();
      if (!prefs.containsKey("accessToken")) {
        await APIService(buildContext).generateTokens(commStore);
      } else if (await checkIfAdmin()) {
        commStore.isAdmin = true;
        commStore.isSpardhaAdmin = prefs.getBool("spardha") ?? false;
        commStore.isKritiAdmin = prefs.getBool("kriti") ?? false;
        commStore.isManthanAdmin = prefs.getBool("manthan") ?? false;
        commStore.isSahyogAdmin = prefs.getBool("sahyog") ?? false;
      }
      StaticStore.spardhaEvents =
          await APIService(buildContext).getAllSpardhaEvents();
      StaticStore.kritiEvents =
          await APIService(buildContext).getAllKritiEvents();
      StaticStore.sahyogEvents =
          await APIService(buildContext).getAllSahyogEvents();
      StaticStore.manthanEvents=
          await APIService(buildContext).getAllManthanEvents();

      return true;
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

}
