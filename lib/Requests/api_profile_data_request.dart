import 'dart:convert';

import 'package:flap/Requests/api_login_requests.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();

const String apiUrl = "http://localhost:8020/api/v1/user/info/";

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
