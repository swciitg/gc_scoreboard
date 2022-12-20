import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:scoreboard/src/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoreboard/src/globals/auth_user_helper.dart';
import 'package:scoreboard/src/globals/database_strings.dart';

class LoginStore{
  Map<String,String> userData={};

  Future<bool> saveUserData(Map<String,String> userInfo) async {
    print(userInfo);
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey("accessToken")){ // has already once used scoreboard
      userData["name"] = userInfo["name"]!;
      userData["email"] = userInfo["email"]!;
      await AuthUserHelpers.setUserData(userInfo);
      await APIService().generateTokens();
    }
    return true;
  }

}