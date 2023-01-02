// ignore: file_names
import 'dart:convert';

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

  static Future<void> handleTokenReceive(String accessToken) async {
    _accessToken = accessToken;
    ApiHandler.setHeaders(
      Options(
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $_accessToken",
        },
      ),
    );
    //call api to get information of user
    await UserController.getUserInformation();
  }

  static Future<LOGIN_STATUS> login(String username, String password) async {
    var res = await requestAccessToken(username, password);
    if (res == "ERROR") return LOGIN_STATUS.FAILED;
    _accessToken = res;
    handleTokenReceive(res);

    return LOGIN_STATUS.SUCCESSFUL;
  }

  static Future<LOGIN_STATUS> googleSignIn(String accessToken) async {
    // var res = await requestAccessToken(username, password);
    String requestURL = "${baseUrl}auth/google";
    Response respond = await ApiHandler.handler
        .post(requestURL, data: {"access_token": accessToken});
    if (respond.statusCode == 200) {
      var body = respond.data;
      AuthToken accessToken = AuthToken.fromJson(body['tokens']['access']);
      AuthToken refreshToken = AuthToken.fromJson(body['tokens']['refresh']);
      await handleTokenReceive(accessToken.token!);
      return LOGIN_STATUS.SUCCESSFUL;
    }

    print(respond.statusCode);

    return LOGIN_STATUS.FAILED;
  }

  static Future<LOGIN_STATUS> facebookSignIn(String accessToken) async {
    // var res = await requestAccessToken(username, password);
    String requestURL = "${baseUrl}auth/facebook";
    Response respond = await ApiHandler.handler
        .post(requestURL, data: {"access_token": accessToken});
    if (respond.statusCode == 200) {
      return LOGIN_STATUS.SUCCESSFUL;
    }

    return LOGIN_STATUS.FAILED;
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
    print("Change pass status: ${respond.statusCode}");
    return respond.statusCode == 200;
  }

  static Future<bool> registerAccount(String email, String password) async {
    String requestUrl = "${baseUrl}auth/register";
    Map payload = {
      "email": email,
      "password": password,
      "source": "https://pay.vnpay.vn/",
    };
    print(json.encode(payload));

    Response respond = await ApiHandler.handler.post(
      requestUrl,
      data: payload,
      options: Options(
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "User-Agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:108.0) Gecko/20100101 Firefox/108.0"
        },
      ),
    );
    return respond.statusCode == 201;
  }
}
