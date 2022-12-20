import 'package:dio/dio.dart';
import 'package:scoreboard/src/globals/auth_user_helper.dart';
import 'package:scoreboard/src/globals/database_strings.dart';

class APIService {

  final dio = Dio(BaseOptions(
      baseUrl: const String.fromEnvironment('SERVER-URL'),
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {'Security-Key': const String.fromEnvironment('SECURITY-KEY')}));

  APIService(){
    dio.interceptors.clear(); // remove old instance of interceptorWrapper added with previous call
    dio.interceptors.add(InterceptorsWrapper(
      onError: (error,handler) async {
        print("in interceptor");
        Response response = error.response!;
        if(response.statusCode==401){
          bool couldRegenerate = await regenerateAccessToken();
          bool isAdmin = await AuthUserHelpers.checkIfAdmin();
          if(couldRegenerate){
            // retry
            print("regenerated access token");
            response.requestOptions.headers[DatabaseRecords.authorization]="Bearer ${await AuthUserHelpers.getAccessToken()}";
            Response retryResponse = await retryRequest(response.requestOptions);
            print(retryResponse.data);
            return handler.resolve(retryResponse);
          }
          else if(isAdmin==false){ // normal user
            await generateTokens();
            response.requestOptions.headers[DatabaseRecords.authorization]="Bearer ${await AuthUserHelpers.getAccessToken()}";
            // retry
            Response retryResponse = await retryRequest(response.requestOptions);
            return handler.resolve(retryResponse);
          }
        }
        // admin user with expired tokens
        return handler.next(error);
      }
    ));
  }

  Future<Response<dynamic>> retryRequest(RequestOptions requestOptions) async {
    final options = Options(method: requestOptions.method,headers: requestOptions.headers);
    Dio retryDio = Dio(BaseOptions(
        baseUrl: const String.fromEnvironment('SERVER-URL'),
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: {'Security-Key': const String.fromEnvironment('SECURITY-KEY')}));
    if(requestOptions.method=="GET"){
      return retryDio.request(requestOptions.path,queryParameters: requestOptions.queryParameters,options: options);
    }
    else{
      print("here");
      return retryDio.request(requestOptions.path,queryParameters: requestOptions.queryParameters,data: requestOptions.data,options: options);
    }
  }

  Future<void> generateTokens() async {
    Map<String,String> userData = await AuthUserHelpers.getUserData();
    Response<Map<String, dynamic>> resp =
        await dio.post("/gc/login", data: {DatabaseRecords.useremail: userData[DatabaseRecords.useremail]});
    var data = resp.data!;
    if (data["success"]==true) {
      // print(data["authEvents"]);
      Map<String, bool> authEvents = {
        "spardha": false,
        "kriti": false,
        "manthan": false
      };
      data[DatabaseRecords.authevents].forEach((element) => {authEvents[element] = true});
      await AuthUserHelpers.setAdmin(data[DatabaseRecords.isadmin]);
      await AuthUserHelpers.setAuthEvents(authEvents);
      await AuthUserHelpers.setAccessToken(data[DatabaseRecords.accesstoken]);
      await AuthUserHelpers.setRefreshToken(data[DatabaseRecords.refreshtoken]);
      print("generated tokens");
    }
  }

  Future<bool> regenerateAccessToken() async {
    String refreshToken = await AuthUserHelpers.getRefreshToken();
    Dio regenDio = Dio(BaseOptions(
        baseUrl: const String.fromEnvironment('SERVER-URL'),
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: {'Security-Key': const String.fromEnvironment('SECURITY-KEY')}));
    Response<Map<String, dynamic>> resp = await regenDio.post("/gc/gen-accesstoken",
        options: Options(headers: {
          "authorization": "Bearer ${refreshToken}"
        }));
    if(resp.statusCode==401) return false;
    var data = resp.data!;
    print("regenerate token");
    await AuthUserHelpers.setAccessToken(data["token"]);
    return true;
  }

}
