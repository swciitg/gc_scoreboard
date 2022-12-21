import 'package:scoreboard/src/globals/helper_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<void> setUserData(Map<String,String> userInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(DatabaseRecords.username, userInfo[DatabaseRecords.username]!);
    await prefs.setString(DatabaseRecords.useremail, userInfo[DatabaseRecords.useremail]!);
  }

  static Future<void> setAuthEvents(Map<String,bool> value) async {
    print(value.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(DatabaseRecords.authevents, value.toString());
  }

}