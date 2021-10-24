import 'dart:convert';

import 'package:http/http.dart' as http;

const String apiUrl = "http://localhost:8020/api/v1/auth/login/";
const String refreshApiUrl = "http://localhost:8020/api/v1/auth/refresh/";

Future<http.Response> loginUser(String username, String password) async {
  var response = http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(
      <String, String>{"username": username, "password": password},
    ),
  );
  return response;
}

Future<http.Response> refreshAccessToken(String? refreshToken) async {
  var response = await http.post(
    Uri.parse(refreshApiUrl),
    headers: {
      "Content-Type": "application/json",
      "refresh": refreshToken ?? ""
    },
    body: jsonEncode(
      <String, String?>{"refresh": refreshToken ?? "123"},
    ),
  );
  return response;
}
