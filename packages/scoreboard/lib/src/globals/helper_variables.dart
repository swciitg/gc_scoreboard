import 'package:connectivity_plus/connectivity_plus.dart';

class DatabaseRecords{
  static const useremail = "email";
  static const username = "name";
  static const isadmin = "isAdmin";
  static const authevents = "authEvents";
  static const authtokens = "authTokens";
  static const refreshtoken = "refreshToken";
  static const accesstoken = "accessToken";
  static const authorization = "authorization";
}

const connectivityResults = [ConnectivityResult.ethernet, ConnectivityResult.mobile, ConnectivityResult.vpn, ConnectivityResult.wifi];


enum apiResponse{
  success, adminRelogin
}