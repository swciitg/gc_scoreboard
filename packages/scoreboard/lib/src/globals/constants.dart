import 'package:connectivity_plus/connectivity_plus.dart';

const List<String> allHostelList = [
  'Barak',
  'Brahmaputra',
  'Dhansiri',
  'Dibang',
  'Dihing',
  'Disang',
  'Kameng',
  'Kapili',
  'Lohit',
  'Manas',
  'Married Scholars',
  'Siang',
  'Subansiri',
  'Umiam'
];

class DatabaseRecords {
  static const useremail = "email";
  static const username = "name";
  static const isadmin = "isAdmin";
  static const authevents = "authEvents";
  static const authtokens = "authTokens";
  static const refreshtoken = "refreshToken";
  static const accesstoken = "accessToken";
  static const authorization = "authorization";
}

const connectivityResults = [
  ConnectivityResult.ethernet,
  ConnectivityResult.mobile,
  ConnectivityResult.vpn,
  ConnectivityResult.wifi
];

const List<String> eventCategories = ['Men', 'Women', 'Men + Women'];

const List<String> spardhaEventStages = [
  'Qualifier',
  'Final',
  'Semi-Final',
  '3rd vs 4th'
];
