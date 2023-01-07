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
  'Married Scholars',
  'Siang',
  'Umiam'
];

const List<String> womenHostel = [
  'Dhansiri',
  'Subansiri',
  'Disang (Women)',
];

const List<String> allHostelList = [...menHostel, ...womenHostel];

const Map<String,String> hostelsImagePath = {
  'Barak' : 'packages/scoreboard/assets/hostel_image.jpg',
  'Brahmaputra' : 'packages/scoreboard/assets/hostel_image.jpg',
  'Dhansiri' : 'packages/scoreboard/assets/hostel_image.jpg',
  'Dibang' : 'packages/scoreboard/assets/hostel_image.jpg',
  'Dihing' : 'packages/scoreboard/assets/hostel_image.jpg',
  'Disang (Men)' : 'packages/scoreboard/assets/hostel_image.jpg',
  'Disang (Women)' : 'packages/scoreboard/assets/hostel_image.jpg',
  'Kameng' : 'packages/scoreboard/assets/hostel_image.jpg',
  'Kapili' : 'packages/scoreboard/assets/hostel_image.jpg',
  'Lohit' : 'packages/scoreboard/assets/hostel_image.jpg',
  'Manas' : 'packages/scoreboard/assets/hostel_image.jpg',
  'Married Scholars' : 'packages/scoreboard/assets/hostel_image.jpg',
  'Siang' : 'packages/scoreboard/assets/hostel_image.jpg',
  'Subansiri' : 'packages/scoreboard/assets/hostel_image.jpg',
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
