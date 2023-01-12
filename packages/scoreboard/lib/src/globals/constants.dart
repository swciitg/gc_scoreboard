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

const String logoDir = 'packages/scoreboard/assets/logos';

const Map<String,String> hostelsImagePath = {
  'Barak' : '$logoDir/barak.jpg',
  'Brahmaputra' : '$logoDir/brahma.jpg',
  'Dhansiri' : '$logoDir/dhansiri.jpg',
  'Dihing' : '$logoDir/dihing.jpg',
  'Disang (Men)' : '$logoDir/disang.jpg',
  'Disang (Women)' : '$logoDir/disang.jpg',
  'Kameng' : '$logoDir/kameng.jpg',
  'Kapili' : '$logoDir/kapili.jpg',
  'Lohit' : '$logoDir/lohit.jpg',
  'Manas' : '$logoDir/hostel_image.jpg',
  'Married Scholars (Men)' : '$logoDir/married_scholar.jpg',
  'Married Scholars (Women)' : '$logoDir/married_scholar.jpg',
  'Siang' : '$logoDir/siang.jpg',
  'Subansiri' : '$logoDir/subansiri.jpg',
  'Umiam' : '$logoDir/umiam.jpg'
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
