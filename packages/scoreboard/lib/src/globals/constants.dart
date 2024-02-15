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

const Map<String, String> hostelsImagePath = {
  'Barak': '$logoDir/barak.jpg',
  'Brahmaputra': '$logoDir/brahma.jpg',
  'Dhansiri': '$logoDir/dhansiri.jpg',
  'Dihing': '$logoDir/dihing.jpg',
  'Disang (Men)': '$logoDir/disang.jpg',
  'Disang (Women)': '$logoDir/disang.jpg',
  'Kameng': '$logoDir/kameng.jpg',
  'Kapili': '$logoDir/kapili.jpg',
  'Lohit': '$logoDir/lohit.jpg',
  'Manas': '$logoDir/manas.jpg',
  'Married Scholars (Men)': '$logoDir/hostel_image.jpg',
  'Married Scholars (Women)': '$logoDir/hostel_image.jpg',
  'Siang': '$logoDir/siang.jpg',
  'Subansiri': '$logoDir/subansiri.jpg',
  'Umiam': '$logoDir/umiam.jpg'
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

const List<String> eventCategories = ['Men', 'Women', 'Men + Women'];

const List<String> spardhaEventStages = [
  'Qualifiers',
  'Finals',
  'Semi-Finals',
  'Quater-Finals',
  '3rd vs 4th'
];

const String kritiWebsiteLink = "https://swc.iitg.ac.in/sa/kriti/";
const String sahyogWebsiteLink = "http://www.google.com/";

const List<String> kritiDifficulties = ["High", "Mid", "Low", "No Prep"];
