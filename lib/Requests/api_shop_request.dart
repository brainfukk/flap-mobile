import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flap/Requests/api_profile_data_request.dart';

final String apiUrlShop = "${dotenv.env['API_URL']}/shop/items/";

Future<http.Response> getShopItems() async {
  var response = await http.get(
    Uri.parse(apiUrlShop),
    headers: {'Content-Type': 'application/json'},
  );
  return response;
}
