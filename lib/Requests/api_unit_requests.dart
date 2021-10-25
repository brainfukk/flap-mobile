import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'api_profile_data_request.dart';

final String apiUrlTopics = "${dotenv.env['API_URL']}/resources/topics/list/";
final String apiUrlUnits = "${dotenv.env['API_URL']}/resources/units/list/";
final String apiUrlUnitsTheory =
    "${dotenv.env['API_URL']}/resources/units/theory/list/";
final String apiUrlUnitsExercises =
    "${dotenv.env['API_URL']}/resources/units/exercise/list/";
final String apiUrlUnitsAnswers =
    "${dotenv.env['API_URL']}/resources/units/exercise/answer/";

final String apiUrlUnitsSearch =
    "${dotenv.env['API_URL']}/resources/units/search/";

const storage = FlutterSecureStorage();

Future<List<dynamic>> getTopics() async {
  var tokenMap = {
    "access": await storage.read(key: "access_token"),
    "refresh": await storage.read(key: "refresh_token")
  };
  var response = await getRequestWithVerifyAuth(
    "GET",
    apiUrlTopics,
    tokenMap["access"],
    tokenMap["refresh"],
    {},
    {},
  );
  String source = const Utf8Decoder().convert(response.bodyBytes);
  return json.decode(source);
}

Future<List<dynamic>> getUnits(String topicId) async {
  var tokenMap = {
    "access": await storage.read(key: "access_token"),
    "refresh": await storage.read(key: "refresh_token")
  };
  var response = await getRequestWithVerifyAuth(
    "GET",
    apiUrlUnits,
    tokenMap["access"],
    tokenMap["refresh"],
    {"topic_id": topicId},
    {},
  );
  String source = const Utf8Decoder().convert(response.bodyBytes);
  return json.decode(source);
}

Future<List<dynamic>> getUnitElements(String unitId) async {
  var tokenMap = {
    "access": await storage.read(key: "access_token"),
    "refresh": await storage.read(key: "refresh_token")
  };

  var response = await getRequestWithVerifyAuth("GET", apiUrlUnitsTheory,
      tokenMap["access"], tokenMap["refresh"], {"unit_id": unitId}, {});
  String source = const Utf8Decoder().convert(response.bodyBytes);
  return json.decode(source);
}

Future<List<dynamic>> getUnitExercises(String unitId) async {
  var tokenMap = {
    "access": await storage.read(key: "access_token"),
    "refresh": await storage.read(key: "refresh_token")
  };

  var response = await getRequestWithVerifyAuth(
    "GET",
    apiUrlUnitsExercises,
    tokenMap["access"],
    tokenMap["refresh"],
    {"unit_id": unitId},
    {},
  );
  String source = const Utf8Decoder().convert(response.bodyBytes);
  return json.decode(source);
}

Future<dynamic> getUserAnswers(String unitId) async {
  var tokenMap = {
    "access": await storage.read(key: "access_token"),
    "refresh": await storage.read(key: "refresh_token")
  };

  var response = await getRequestWithVerifyAuth(
    "POST",
    apiUrlUnitsAnswers,
    tokenMap["access"],
    tokenMap["refresh"],
    {"unit_id": unitId},
    {},
  );

  String source = const Utf8Decoder().convert(response.bodyBytes);
  return json.decode(source);
}

Future<dynamic> submitAnswers(
    Map<String, dynamic> answers, String unitId) async {
  var tokenMap = {
    "access": await storage.read(key: "access_token"),
    "refresh": await storage.read(key: "refresh_token")
  };

  var response = await postRequestWithVerifyAuth(
    "POST",
    apiUrlUnitsAnswers,
    tokenMap["access"],
    tokenMap["refresh"],
    {},
    {"unit_id": unitId, "answers": answers},
  );

  String source = const Utf8Decoder().convert(response.bodyBytes);
  return json.decode(source);
}

Future<List<dynamic>> searchForUnits(String searchPhrase) async {
  var tokenMap = {
    "access": await storage.read(key: "access_token"),
    "refresh": await storage.read(key: "refresh_token")
  };

  var response = await getRequestWithVerifyAuth(
    "GET",
    apiUrlUnitsSearch,
    tokenMap["access"],
    tokenMap["refresh"],
    {"search_phrase": searchPhrase},
    {},
  );
  String source = const Utf8Decoder().convert(response.bodyBytes);
  return json.decode(source);
}
