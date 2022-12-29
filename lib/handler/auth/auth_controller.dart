// ignore: file_names
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:let_tutor/handler/api_handler.dart';
import 'package:let_tutor/handler/auth/auth_token.dart';
import 'package:let_tutor/handler/user/user_controller.dart';

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

    //Add refresh token
    // ApiHandler.handler.interceptors.add(Interceptor());

    if (respond.statusCode == 200) {
      var body = respond.data;
      AuthToken accessToken = AuthToken.fromJson(body['tokens']['access']);
      AuthToken refreshToken = AuthToken.fromJson(body['tokens']['refresh']);
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
    //call api to get information of user
    UserController.getUserInformation();
    return LOGIN_STATUS.SUCCESSFUL;
  }

  static String getAccessToken() {
    return _accessToken;
  }

  static Future<bool> changePassword(
      String oldPassword, String newPassword) async {
    String requestUrl = "${baseUrl}auth/change-password";
    Response respond = await ApiHandler.handler.post(
      requestUrl,
      options: ApiHandler.getHeaders(),
      data: {
        "password": oldPassword,
        "newPassword": newPassword,
      },
    );
    return respond.statusCode == 200;
  }
}
