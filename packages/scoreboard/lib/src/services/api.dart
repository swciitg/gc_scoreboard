import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/src/functions/auth_user_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:scoreboard/src/globals/enums.dart';
import 'package:scoreboard/src/models/event_model.dart';
import 'package:scoreboard/src/models/result_model.dart';
import 'package:scoreboard/src/screens/login/admin_login.dart';

import '../globals/constants.dart';

class APIService {
  final dio = Dio(BaseOptions(
      baseUrl: const String.fromEnvironment('SERVER-URL'),
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {'Security-Key': const String.fromEnvironment('SECURITY-KEY')}));

  APIService(BuildContext buildContext){
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options,handler) async {
        options.headers["Authorization"] = "Bearer ${await AuthUserHelpers.getAccessToken()}";
        print(options.headers["Authorization"]);
        handler.next(options);
      },
      onError: (error,handler) async {
        print("in interceptor");
        Response response = error.response!;
        print(response.statusCode ?? "no status code");
        if(response.statusCode==401){
          print("inside here");
          bool couldRegenerate = await regenerateAccessToken();
          bool isAdmin = await AuthUserHelpers.checkIfAdmin();
          print(isAdmin);
          if(couldRegenerate){
            // retry
            print("regenerated access token");
            return handler.resolve(await retryRequest(response));
          }
          else if(isAdmin==false){// normal user
            await generateTokens();
            // retry
            return handler.resolve(await retryRequest(response));
          }
          else{
            print("here");
            // show login screen to admin if only he has internet connection
            var connectivityResult = await (Connectivity().checkConnectivity());
            if(connectivityResults.contains(connectivityResult) && await Navigator.pushNamed(buildContext, LoginView.id) == true){
              print("verified admin via login");
              await generateTokens();
              print("regenerated tokens for admin");
              // retry
              return handler.resolve(await retryRequest(response));
            }
          }
        }
        // admin user with expired tokens
        return handler.next(error);
      }
    ));
  }

  Future<Response<dynamic>> retryRequest(Response response) async {
    RequestOptions requestOptions = response.requestOptions;
    response.requestOptions.headers[DatabaseRecords.authorization]="Bearer ${await AuthUserHelpers.getAccessToken()}";
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

  Future<void> testAPI() async {
    var resp = await dio.post("/gc/test",data: {"text" : "test"});
    print(resp);
  }

  Future<void> postEventSchedule(Map<String,dynamic> data) async {
    var resp = await dio.post("/gc/spardha/event-schedule",data: data);
    print(resp);
  }

  Future<void> generateTokens() async {
    Map<String,String> userData = await AuthUserHelpers.getUserData();
    print(userData);
    Response<Map<String, dynamic>> resp =
        await dio.post("/gc/login", data: {DatabaseRecords.useremail: userData[DatabaseRecords.useremail]});
    var data = resp.data!;
    print(data);
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
    print(refreshToken);
    try{
      Dio regenDio = Dio(BaseOptions(
          baseUrl: const String.fromEnvironment('SERVER-URL'),
          connectTimeout: 5000,
          receiveTimeout: 5000,
          headers: {'Security-Key': const String.fromEnvironment('SECURITY-KEY')}));
      Response<Map<String, dynamic>> resp = await regenDio.post("/gc/gen-accesstoken",
          options: Options(headers: {
            "authorization": "Bearer ${refreshToken}"
          }));
      print(resp);
      var data = resp.data!;
      print("regenerate token");
      await AuthUserHelpers.setAccessToken(data["token"]);
      return true;
    }
    catch (err){
      print("resp 401");
      return false;
    }
  }

  Future<List<String>> getAllSpardhaEvents() async {
    Response resp = await dio.get("/gc/spardha/all-events");
    print(resp.data["details"]); // it is List of dynamic
    return List<String>.from(resp.data["details"]);
  }

  Future<List<EventModel>> getSpardhaSchedule(ViewType viewType,String selectedDate) async {
    if(viewType == ViewType.admin){
      dio.options.queryParameters["forAdmin"] = "true";
    }
    if(selectedDate.isNotEmpty){
      dio.options.queryParameters["date"]=selectedDate;
    }
    Response resp = await dio.get("/gc/spardha/event-schedule");
    List<EventModel> toRtn = [];
    print(resp.data);
    List<dynamic>.from(resp.data["details"]).forEach((e) => {toRtn.add(EventModel.fromJson(e))});
    return toRtn;
  }

}
