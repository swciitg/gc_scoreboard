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
const List<String> eventCategories = ['Men', 'Women', 'Men and Women'];
const List<String> spardhaEventStages = [
  'Qualifier',
  'Finals',
  'Semi-Final',
  '3rd vs 4th'
];

enum apiResponse{
  success, adminRelogin
}