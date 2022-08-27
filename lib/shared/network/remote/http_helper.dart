import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  static const String baseUrl = "http://192.168.43.176:5000";

  static Future<http.Response> getData({
    required String url,
  }) async {
    var response = await http.get(Uri.parse("$baseUrl/$url"));
    return response;
  }

  static Future<http.Response> postData(
      {required String url, required Map<String, dynamic> data}) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.post(
      Uri.parse("$baseUrl/$url"),
      headers: headers,
      body: jsonEncode(data),
    );
    return response;
  }
}
