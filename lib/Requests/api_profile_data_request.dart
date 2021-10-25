import 'dart:convert';

import 'package:flap/Requests/api_login_requests.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();

const String apiUrl = "http://192.168.1.77:8020/api/v1/user/info/";
final String apiUrlNotification = "${dotenv.env['API_URL']}/user/events/";
final String apiUrlUnitProgess =
    "${dotenv.env['API_URL']}/user/user_unit_relates/";

Map<String, String> getHeaders(accessToken) {
  return {
    "Content-Type": "application/json",
    "Authorization": "Bearer $accessToken"
  };
}

Future<http.Response> getRequestWithVerifyAuth(
  String method,
  String url,
  String? accessToken,
  String? refreshToken,
  Map<String, dynamic>? queryParams,
  Map<String, dynamic> body,
) async {
  String queryString = Uri(queryParameters: queryParams).query;

  var response = await http.get(
    Uri.parse(url + "?$queryString"),
    headers: getHeaders(accessToken),
  );

  if (response.statusCode == 401) {
    var responseToken = await refreshAccessToken(refreshToken);
    var data = jsonDecode(responseToken.body);
    await storage.write(key: "access_token", value: data["access"]);
    return await getRequestWithVerifyAuth(
      method,
      url,
      accessToken,
      refreshToken,
      queryParams,
      body,
    );
  }

  return response;
}

Future<http.Response> putRequestWithVerifyAuth(
  String method,
  String url,
  String? accessToken,
  String? refreshToken,
  Map<String, dynamic>? queryParams,
  Map<String, dynamic> body,
) async {
  String queryString = Uri(queryParameters: queryParams).query;

  var response = await http.put(Uri.parse(url + "?$queryString"),
      headers: getHeaders(accessToken), body: jsonEncode(body));

  if (response.statusCode == 401) {
    var responseToken = await refreshAccessToken(refreshToken);
    var data = jsonDecode(responseToken.body);
    await storage.write(key: "access_token", value: data["access"]);
    return await putRequestWithVerifyAuth(
      method,
      url,
      accessToken,
      refreshToken,
      queryParams,
      body,
    );
  }
  return response;
}

Future<http.Response> postRequestWithVerifyAuth(
  String method,
  String url,
  String? accessToken,
  String? refreshToken,
  Map<String, dynamic>? queryParams,
  Map<String, dynamic> body,
) async {
  String queryString = Uri(queryParameters: queryParams).query;

  var response = await http.post(
    Uri.parse(url),
    headers: getHeaders(accessToken),
    body: jsonEncode(body),
  );

  if (response.statusCode == 401) {
    var responseToken = await refreshAccessToken(refreshToken);
    var data = jsonDecode(responseToken.body);
    await storage.write(key: "access_token", value: data["access"]);
    return await postRequestWithVerifyAuth(
      method,
      url,
      accessToken,
      refreshToken,
      queryParams,
      body,
    );
  }

  return response;
}

Future<http.Response> getUserInfo() async {
  var tokenMap = {
    "access": await storage.read(key: "access_token"),
    "refresh": await storage.read(key: "refresh_token")
  };
  return getRequestWithVerifyAuth(
    "GET",
    apiUrl,
    tokenMap["access"],
    tokenMap["refresh"],
    {},
    {},
  );
}

Future<http.Response> getUserNotification() async {
  var tokenMap = {
    "access": await storage.read(key: "access_token"),
    "refresh": await storage.read(key: "refresh_token")
  };

  return await getRequestWithVerifyAuth("GET", apiUrlNotification,
      tokenMap["access"], tokenMap["refresh"], {}, {});
}

Future<http.Response> putUserNotification(int notification_id) async {
  var tokenMap = {
    "access": await storage.read(key: "access_token"),
    "refresh": await storage.read(key: "refresh_token")
  };
  var apiUrl = apiUrlNotification + notification_id.toString() + "/";

  return await putRequestWithVerifyAuth("PUT", apiUrl, tokenMap["access"],
      tokenMap["refresh"], {}, {"is_hidden": true});
}

Future<http.Response> getUnitProgess() async {
  var tokenMap = {
    "access": await storage.read(key: "access_token"),
    "refresh": await storage.read(key: "refresh_token")
  };
  var response = await getRequestWithVerifyAuth(
    "GET",
    apiUrlUnitProgess,
    tokenMap["access"],
    tokenMap["refresh"],
    {},
    {},
  );
  // String source = const Utf8Decoder().convert(response.bodyBytes);
  return response;
}
