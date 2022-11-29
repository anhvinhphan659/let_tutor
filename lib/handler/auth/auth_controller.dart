// ignore: file_names
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:let_tutor/handler/api_handler.dart';

// ignore: camel_case_types
enum LOGIN_STATUS { SUCCESSFUL, FAILED }

class AuthController {
  static const String path = 'auth/login';
  static String _accessToken = "";

  static Future<String> requestAccessToken(
      String username, String password) async {
    Map<String, String> body = {
      "email": username,
      "password": password,
    };
    var respond = await ApiHandler.handler.post(baseUrl + path, data: body);

    if (respond.statusCode == 200) {
      return respond.data['tokens']['access']['token'];
    }
    return "ERROR";
  }

  static Future<LOGIN_STATUS> login(String username, String password) async {
    var res = await requestAccessToken(username, password);
    if (res == "ERROR") return LOGIN_STATUS.FAILED;
    _accessToken = res;
    print(_accessToken);
    ApiHandler.setHeaders(
      Options(
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $_accessToken",
        },
      ),
    );
    return LOGIN_STATUS.SUCCESSFUL;
  }

  static String getAccessToken() {
    return _accessToken;
  }
}
