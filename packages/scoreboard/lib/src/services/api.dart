import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/functions/snackbar.dart';
import '../functions/auth_user_helper.dart';
import '../globals/constants.dart';
import '../globals/enums.dart';
import '../models/sahyog_models/sahyog_event_model.dart';
import '../models/sahyog_models/sahyog_result_model.dart';
import '../models/spardha_models/spardha_event_model.dart';
import '../models/kriti_models/kriti_event_model.dart';
import '../models/kriti_models/kriti_result_model.dart';
import '../models/spardha_models/spardha_result_model.dart';
import '../models/standing_model.dart';
import '../stores/common_store.dart';

class APIService {
  final dio = Dio(BaseOptions(
      baseUrl: const String.fromEnvironment('SERVER-URL'),
      connectTimeout: 15000,
      receiveTimeout: 15000,
      headers: {'Security-Key': const String.fromEnvironment('SECURITY-KEY')}));

  APIService(BuildContext buildContext) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers["Authorization"] =
          "Bearer ${await AuthUserHelpers.getAccessToken()}";
      handler.next(options);
    }, onError: (error, handler) async {
      var response = error.response;
      // print(response.statusCode ?? "no status code");

      if (response != null && response.statusCode == 401) {
        print(response.requestOptions.path);
        bool couldRegenerate = await regenerateAccessToken();
        var commStore = buildContext.read<CommonStore>();
        if (couldRegenerate) {
          // retry
          return handler.resolve(await retryRequest(response));
        } else if (!commStore.isAdmin) {
          // normal user
          await generateTokens(commStore);
          // retry
          return handler.resolve(await retryRequest(response));
        } else {
          showSnackBar(buildContext,
              "Your session has expired!! Login again in OneStop.");
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
      return retryDio.request(requestOptions.path,
          queryParameters: requestOptions.queryParameters,
          data: requestOptions.data,
          options: options);
    }
  }

  Future<dynamic> generateTokens(CommonStore commStore) async {
    Map<String, String> userData = await AuthUserHelpers.getUserData();
    Response<Map<String, dynamic>> resp = await dio.post("/gc/login",
        data: {DatabaseRecords.useremail: userData[DatabaseRecords.useremail]});
    var data = resp.data!;
    if (data["success"] == true) {
      commStore.setAdminNone();
      Map<String, bool> authCompetitions = {
        "spardha": false,
        "kriti": false,
        "manthan": false,
        "sahyog": false
      };
      data[DatabaseRecords.authevents].forEach((element) => {
            authCompetitions[element] = true,
            if (element == "spardha")
              {commStore.setSpardhaAdmin(true)}
            else if (element == "kriti")
              {commStore.setKritiAdmin(true)}
            else if (element == "manthan")
              {commStore.setManthanAdmin(true)}
            else if (element == "sahyog")
              {commStore.setSahyogAdmin(true)}
          });
      await AuthUserHelpers.saveAuthCompetitions(authCompetitions);
      await AuthUserHelpers.setAdmin(data[DatabaseRecords.isadmin]);
      await AuthUserHelpers.setAccessToken(data[DatabaseRecords.accesstoken]);
      await AuthUserHelpers.setRefreshToken(data[DatabaseRecords.refreshtoken]);
    }
  }

  Future<bool> regenerateAccessToken() async {
    String refreshToken = await AuthUserHelpers.getRefreshToken();
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
          options: Options(headers: {"authorization": "Bearer $refreshToken"}));
      var data = resp.data!;
      await AuthUserHelpers.setAccessToken(data["token"]);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<void> postEventSchedule(Map<String, dynamic> data) async {
    try {
      var resp = await dio.post("/gc/spardha/event-schedule", data: data);
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<List<String>> getAllSpardhaEvents() async {
    try {
      Response resp = await dio.get("/gc/spardha/all-events");
      return List<String>.from(resp.data["details"]);
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<List<EventModel>> getSpardhaSchedule(ViewType v) async {
    try {
      if (v == ViewType.admin) {
        dio.options.queryParameters["forAdmin"] = "true";
      }
      Response resp = await dio.get("/gc/spardha/event-schedule");
      List<EventModel> output = [];
      for (var e in List<dynamic>.from(resp.data["details"])) {
        {
          output.add(EventModel.fromJson(e));
        }
      }
      return output;
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<List<EventModel>> getSpardhaResults(ViewType v) async {
    try {
      if (v == ViewType.admin) {
        dio.options.queryParameters["forAdmin"] = "true";
      }
      Response resp = await dio.get("/gc/spardha/event-schedule/results");
      List<EventModel> output = [];
      for (var e in List<dynamic>.from(resp.data["details"])) {
        {
          output.add(EventModel.fromJson(e));
        }
      }
      return output;
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<List<KritiEventModel>> getKritiResults(ViewType v) async {
    try {
      if (v == ViewType.admin) {
        dio.options.queryParameters["forAdmin"] = "true";
      }
      Response resp = await dio.get("/gc/kriti/event-schedule/results");
      List<KritiEventModel> output = [];
      for (var e in List<dynamic>.from(resp.data["details"])) {
        {
          output.add(KritiEventModel.fromJson(e));
        }
      }
      return output;
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<List<SahyogEventModel>> getSahyogResults(ViewType v) async {
    try {
      if (v == ViewType.admin) {
        dio.options.queryParameters["forAdmin"] = "true";
      }
      Response resp = await dio.get("/gc/sahyog/event-schedule/results");
      List<SahyogEventModel> output = [];
      for (var e in List<dynamic>.from(resp.data["details"])) {
        {
          output.add(SahyogEventModel.fromJson(e));
        }
      }
      return output;
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> addUpdateResult(String eventID, List<List<ResultModel>> data,
      String victoryStatement) async {
    try {
      List<List<Map>> results = [];
      for (var positionResults in data) {
        List<Map> addResults = [];
        for (var result in positionResults) {
          addResults.add(result.toJson());
        }
        results.add(addResults);
      }
      Response resp = await dio.patch(
          '/gc/spardha/event-schedule/result/$eventID',
          data: {'victoryStatement': victoryStatement, 'results': results});
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> addUpdateKritiResult(String eventID, List<KritiResultModel> data,
      String victoryStatement) async {
    try {
      List<Map> results = [];
      for (var positionResults in data) {
        results.add(positionResults.toJson());
      }
      Response resp = await dio.patch(
          '/gc/kriti/event-schedule/result/$eventID',
          data: {'victoryStatement': victoryStatement, 'results': results});
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> addUpdateSahyogResult(String eventID,
      List<SahyogResultModel> data, String victoryStatement) async {
    try {
      List<Map> results = [];
      for (var positionResults in data) {
        results.add(positionResults.toJson());
      }
      Response resp = await dio.patch(
          '/gc/sahyog/event-schedule/result/$eventID',
          data: {'victoryStatement': victoryStatement, 'results': results});
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> deleteEvent(String eventID) async {
    try {
      Response resp = await dio.delete('/gc/spardha/event-schedule/$eventID');
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> updateSpardhaEvent(EventModel event) async {
    try {
      Response resp = await dio.patch('/gc/spardha/event-schedule/${event.id!}',
          data: event.toJson());
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> deleteSpardhaEventResult(String eventID) async {
    try {
      await dio.delete('/gc/spardha/event-schedule/result/$eventID');
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<Map<String, dynamic>> getSpardhaStandings() async {
    try {
      Response resp1 = await dio.get("/gc/spardha/standings/all-events");
      Response resp2 = await dio.get("/gc/spardha/standings");
      return {
        "overall": resp2.data["details"],
        "event-wise": resp1.data["details"]
      };
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<List<dynamic>> getGCStandings() async {
    try {
      Response resp = await dio.get("/gc/overall/standings");
      return resp.data['details'];
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> postSpardhaStanding(Map<String, dynamic> data) async {
    try {
      Response resp = await dio.post("/gc/spardha/standings", data: data);
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> updateSpardhaStanding(StandingModel standingModel) async {
    try {
      Response resp = await dio.patch(
          "/gc/spardha/standings/${standingModel.id}",
          data: standingModel.toJson());
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<bool> deleteStanding(String standingID) async {
    try {
      Response resp = await dio.delete("/gc/spardha/standings/$standingID");
      return resp.data['success'];
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  // kriti

  Future<List<String>> getAllKritiEvents() async {
    try {
      Response resp = await dio.get("/gc/kriti/all-events");
      return List<String>.from(resp.data["details"]);
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<List<String>> getAllSahyogEvents() async {
    try {
      Response resp = await dio.get("/gc/sahyog/all-events");
      return List<String>.from(resp.data["details"]);
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<Map<String, dynamic>> getKritiStandings() async {
    try {
      Response resp1 = await dio.get("/gc/kriti/standings/all-events");
      Response resp2 = await dio.get("/gc/kriti/standings");
      return {
        "overall": resp2.data["details"],
        "event-wise": resp1.data["details"]
      };
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<Map<String, dynamic>> getSahyogStandings() async {
    try {
      Response resp1 = await dio.get("/gc/sahyog/standings/all-events");
      Response resp2 = await dio.get("/gc/sahyog/standings");
      return {
        "overall": resp2.data["details"],
        "event-wise": resp1.data["details"]
      };
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<List<KritiEventModel>> getKritiSchedule(ViewType v) async {
    try {
      if (v == ViewType.admin) {
        dio.options.queryParameters["forAdmin"] = "true";
      }
      Response resp = await dio.get("/gc/kriti/event-schedule");
      List<KritiEventModel> output = [];
      for (var e in List<dynamic>.from(resp.data["details"])) {
        {
          output.add(KritiEventModel.fromJson(e));
        }
      }
      return output;
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<List<SahyogEventModel>> getSahyogSchedule(ViewType v) async {
    try {
      if (v == ViewType.admin) {
        dio.options.queryParameters["forAdmin"] = "true";
      }
      Response resp = await dio.get("/gc/sahyog/event-schedule");
      List<SahyogEventModel> output = [];
      for (var e in List<dynamic>.from(resp.data["details"])) {
        {
          output.add(SahyogEventModel.fromJson(e));
        }
      }
      return output;
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> postKritiEventSchedule(Map<String, dynamic> data) async {
    try {
      await dio.post("/gc/kriti/event-schedule", data: data);
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> postSahyogEventSchedule(Map<String, dynamic> data) async {
    try {
      await dio.post("/gc/sahyog/event-schedule", data: data);
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> updateKritiEvent(KritiEventModel event) async {
    try {
      await dio.patch('/gc/kriti/event-schedule/${event.id!}',
          data: event.toJson());
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> updateSahyogEvent(SahyogEventModel event) async {
    try {
      await dio.patch('/gc/sahyog/event-schedule/${event.id!}',
          data: event.toJson());
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> deleteKritiEvent(String eventID) async {
    try {
      await dio.delete('/gc/kriti/event-schedule/$eventID');
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> deleteSahyogEvent(String eventID) async {
    try {
      await dio.delete('/gc/sahyog/event-schedule/$eventID');
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> deleteKritiEventResult(String eventID) async {
    try {
      await dio.delete('/gc/kriti/event-schedule/result/$eventID');
    } on DioError catch (err) {
      return Future.error(err);
    }
  }

  Future<void> deleteSahyogEventResult(String eventID) async {
    try {
      await dio.delete('/gc/sahyog/event-schedule/result/$eventID');
    } on DioError catch (err) {
      return Future.error(err);
    }
  }
}
