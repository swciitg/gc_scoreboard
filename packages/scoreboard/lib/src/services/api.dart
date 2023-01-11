import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:scoreboard/src/models/standing_model.dart';

import '../functions/auth_user_helper.dart';
import '../globals/constants.dart';
import '../globals/enums.dart';
import '../models/event_model.dart';
import '../models/result_model.dart';
import '../screens/login/admin_login.dart';
import '../stores/common_store.dart';

class APIService {
  final dio = Dio(BaseOptions(
      baseUrl: const String.fromEnvironment('SERVER-URL'),
      connectTimeout: 15000,
      receiveTimeout: 15000,
      headers: {'Security-Key': const String.fromEnvironment('SECURITY-KEY')}));

  APIService(BuildContext buildContext) {
    print(const String.fromEnvironment('SERVER-URL'));
    print(const String.fromEnvironment('SECURITY-KEY'));
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers["Authorization"] =
          "Bearer ${await AuthUserHelpers.getAccessToken()}";
      print(options.headers["Authorization"]);
      handler.next(options);
    }, onError: (error, handler) async {
      print(error.toString());
      print("in interceptor");
      var response = error.response;
      // print(response.statusCode ?? "no status code");
      if (response!=null && response.statusCode == 401) {
        print("inside here");
        bool couldRegenerate = await regenerateAccessToken();
        bool isAdmin = await AuthUserHelpers.checkIfAdmin();
        print(isAdmin);
        if (couldRegenerate) {
          // retry
          print("regenerated access token");
          return handler.resolve(await retryRequest(response));
        } else if (isAdmin == false) {
          // normal user
          await generateTokens(buildContext.read<CommonStore>());
          // retry
          return handler.resolve(await retryRequest(response));
        } else {
          print("here");
          // show login screen to admin if only he has internet connection
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResults.contains(connectivityResult) &&
              await Navigator.pushNamed(buildContext, LoginView.id) == true) {
            print("verified admin via login");
            await generateTokens(buildContext.read<CommonStore>());
            print("regenerated tokens for admin");
            // retry
            return handler.resolve(await retryRequest(response));
          }
        }
      }
      // admin user with expired tokens
      return handler.next(error);
    }));
  }

  Future<Response<dynamic>> retryRequest(Response response) async {
    RequestOptions requestOptions = response.requestOptions;
    response.requestOptions.headers[DatabaseRecords.authorization] =
        "Bearer ${await AuthUserHelpers.getAccessToken()}";
    final options =
        Options(method: requestOptions.method, headers: requestOptions.headers);
    Dio retryDio = Dio(BaseOptions(
        baseUrl: const String.fromEnvironment('SERVER-URL'),
        connectTimeout: 5000,
        receiveTimeout: 5000,
        headers: {
          'Security-Key': const String.fromEnvironment('SECURITY-KEY')
        }));
    if (requestOptions.method == "GET") {
      return retryDio.request(requestOptions.path,
          queryParameters: requestOptions.queryParameters, options: options);
    } else {
      print("here");
      return retryDio.request(requestOptions.path,
          queryParameters: requestOptions.queryParameters,
          data: requestOptions.data,
          options: options);
    }
  }

  Future<void> testAPI() async {
    var resp = await dio.post("/gc/test", data: {"text": "test"});
    print(resp);
  }

  Future<bool> postEventSchedule(Map<String, dynamic> data) async {
    var resp = await dio.post("/gc/spardha/event-schedule", data: data);
    print(resp);
    return resp.data['success'];
  }

  Future<dynamic> generateTokens(CommonStore commStore) async {
    Map<String, String> userData = await AuthUserHelpers.getUserData();
    print(userData);
    Response<Map<String, dynamic>> resp = await dio.post("/gc/login",
        data: {DatabaseRecords.useremail: userData[DatabaseRecords.useremail]});
    var data = resp.data!;
    print(data);
    if (data["success"] == true) {
      commStore.setAdminNone();
      data[DatabaseRecords.authevents].forEach((element) => {
            if (element == "spardha")
              {commStore.setSpardhaAdmin(true)}
            else if (element == "kriti")
              {commStore.setKritiAdmin(true)}
            else if (element == "manthan")
              {commStore.setManthanAdmin(true)}
          });
      await AuthUserHelpers.setAdmin(data[DatabaseRecords.isadmin]);
      await AuthUserHelpers.setAccessToken(data[DatabaseRecords.accesstoken]);
      await AuthUserHelpers.setRefreshToken(data[DatabaseRecords.refreshtoken]);
      print("generated tokens");
    }
  }

  Future<bool> regenerateAccessToken() async {
    String refreshToken = await AuthUserHelpers.getRefreshToken();
    print(refreshToken);
    try {
      Dio regenDio = Dio(BaseOptions(
          baseUrl: const String.fromEnvironment('SERVER-URL'),
          connectTimeout: 5000,
          receiveTimeout: 5000,
          headers: {
            'Security-Key': const String.fromEnvironment('SECURITY-KEY')
          }));
      Response<Map<String, dynamic>> resp = await regenDio.post(
          "/gc/gen-accesstoken",
          options:
              Options(headers: {"authorization": "Bearer ${refreshToken}"}));
      print(resp);
      var data = resp.data!;
      print("regenerate token");
      await AuthUserHelpers.setAccessToken(data["token"]);
      return true;
    } catch (err) {
      print("resp 401");
      return false;
    }
  }

  Future<List<String>> getAllSpardhaEvents() async {
    try{
      print("here");
      Response resp = await dio.get("/gc/spardha/all-events");
      print(resp.data["details"]); // it is List of dynamic
      return List<String>.from(resp.data["details"]);
    }
    on DioError catch (err){
      print("inside api");
      print(err);
      return Future.error(err);
    }
  }

  Future<List<EventModel>> getSpardhaSchedule(ViewType viewType) async {
    try{
      // throw DioError(requestOptions: RequestOptions(path: "gf"));
      if (viewType == ViewType.admin) {
        dio.options.queryParameters["forAdmin"] = "true";
      }
      Response resp = await dio.get("/gc/spardha/event-schedule");
      List<EventModel> output = [];
      print(resp.data);
      List<dynamic>.from(resp.data["details"])
          .forEach((e) => {output.add(EventModel.fromJson(e))});
      return output;
    }
    on DioError catch (err){
      print("inside api");
      print(err);
      return Future.error(err);
    }
  }

  Future<List<EventModel>> getSpardhaResults(ViewType viewType) async {
    try{
      // throw DioError(requestOptions: RequestOptions(path: "gf"));
      if (viewType == ViewType.admin) {
        dio.options.queryParameters["forAdmin"] = "true";
      }
      Response resp = await dio.get("/gc/spardha/event-schedule/results");
      List<EventModel> output = [];
      print(resp.data);
      List<dynamic>.from(resp.data["details"])
          .forEach((e) => {output.add(EventModel.fromJson(e))});
      return output;
    }
    on DioError catch (err){
      print("inside api");
      print(err);
      return Future.error(err);
    }
  }

  Future<bool> addUpdateResult(String eventID, List<List<ResultModel>> data,
      String victoryStatement) async {
    List<List<Map>> results = [];
    data.forEach((positionResults) {
      List<Map> addResults = [];
      positionResults.forEach((result) {
        addResults.add(result.toJson());
      });
      results.add(addResults);
    });
    print(results);
    Response resp = await dio.patch(
        '/gc/spardha/event-schedule/result/$eventID',
        data: {'victoryStatement': victoryStatement, 'results': results});
    print(resp.data);
    return resp.data['success'];
  }

  Future<bool> deleteEvent(String eventID) async {
    Response resp = await dio.delete('/gc/spardha/event-schedule/$eventID');
    return resp.data['success'];
  }

  Future<bool> updateSpardhaEvent(EventModel event) async {
    print(event.id);
    Response resp = await dio.patch('/gc/spardha/event-schedule/${event.id!}',
        data: event.toJson());
    return resp.data['success'];
  }

  Future<bool> deleteSpardhaEventResult(String eventID) async {
    Response resp =
        await dio.delete('/gc/spardha/event-schedule/result/$eventID');
    return resp.data['success'];
  }

  Future<Map<String, dynamic>> getSpardhaStandings() async {
    try{
      Response resp1 = await dio.get("/gc/spardha/standings/all-events");
      Response resp2 = await dio.get("/gc/spardha/standings");
      // throw DioError(requestOptions: RequestOptions(path: "gf"));
      return {
        "overall": resp2.data["details"],
        "event-wise": resp1.data["details"]
      };
    }
    on DioError catch (err){
      print("inside api");
      print(err);
      return Future.error(err);
    }
  }

  Future<List<dynamic>> getGCStandings() async {
    try{
      // throw DioError(requestOptions: RequestOptions(path: "gf"));
      Response resp = await dio.get("/gc/overall/standings");
      return resp.data['details'];
    }
    on DioError catch (err){
      print("inside api");
      print(err);
      return Future.error(err);
    }
  }

  Future<bool> postSpardhaStanding(Map<String, dynamic> data) async {
    try{
      Response resp = await dio.post("/gc/spardha/standings", data: data);
      return resp.data['success'];
    }
    on DioError catch (err){
      print("inside api");
      print(err);
      return Future.error(err);
    }
  }

  Future<bool> updateSpardhaStanding(StandingModel standingModel) async {
    try{
      Response resp = await dio.patch("/gc/spardha/standings/${standingModel.id}", data: standingModel.toJson());
      return resp.data['success'];
    }
    on DioError catch (err){
      print("inside api");
      print(err);
      return Future.error(err);
    }
  }

  Future<bool> deleteStanding(String standingID) async {
    Response resp = await dio.delete("/gc/spardha/standings/${standingID}");
    return resp.data['success'];
  }


}
