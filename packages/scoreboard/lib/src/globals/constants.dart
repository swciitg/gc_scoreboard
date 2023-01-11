import 'package:connectivity_plus/connectivity_plus.dart';
const List<String> menHostel = [
  'Barak',
  'Brahmaputra',
  'Dihing',
  'Disang (Men)',
  'Kameng',
  'Kapili',
  'Lohit',
  'Manas',
  'Married Scholars (Men)',
  'Siang',
  'Umiam'
];

const List<String> womenHostel = [
  'Dhansiri',
  'Subansiri',
  'Disang (Women)',
  'Married Scholars (Women)'
];

const List<String> allHostelList = [...menHostel, ...womenHostel];

const Map<String,String> hostelsImagePath = {
  'Barak' : 'packages/scoreboard/assets/barak.svg',
  'Brahmaputra' : 'packages/scoreboard/assets/brahmaputra.svg',
  'Dhansiri' : 'packages/scoreboard/assets/dhansiri.svg',
  'Dihing' : 'packages/scoreboard/assets/dihing.svg',
  'Disang (Men)' : 'packages/scoreboard/assets/disang.svg',
  'Disang (Women)' : 'packages/scoreboard/assets/disang.svg',
  'Kameng' : 'packages/scoreboard/assets/kameng.svg',
  'Kapili' : 'packages/scoreboard/assets/kapili.svg',
  'Lohit' : 'packages/scoreboard/assets/lohit.svg',
  'Manas' : 'packages/scoreboard/assets/manas.svg',
  'Married Scholars (Men)' : 'packages/scoreboard/assets/married_scholar.svg',
  'Married Scholars (Women)' : 'packages/scoreboard/assets/married_scholar.svg',
  'Siang' : 'packages/scoreboard/assets/siang.svg',
  'Subansiri' : 'packages/scoreboard/assets/subansiri.svg',
  'Umiam' : 'packages/scoreboard/assets/hostel_image.jpg'
};

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
  'Qualifiers',
  'Finals',
  'Semi-Finals',
  'Quater-Finals',
  '3rd vs 4th'
];
