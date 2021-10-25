import 'dart:convert';

import 'package:http/http.dart' as http;

const String apiUrl = "http://192.168.1.77:8020/api/v1/auth/register/";

Future<http.Response> registerUser(username, email, password) async {
  var response = await http.post(
    Uri.parse(apiUrl + "step-1/"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(
      <String, String>{
        "username": username,
        "email": email,
        "password": password
      },
    ),
  );
  return response;
}

Future<http.Response> confirmEmail(username, email, token) async {
  var response = await http.post(
    Uri.parse(apiUrl + "step-2/"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(
      <String, String>{
        "token": token,
        "username": username,
        "email": email,
      },
    ),
  );
  return response;
}
