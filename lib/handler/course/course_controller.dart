import 'dart:io';

import 'package:dio/dio.dart';
import 'package:let_tutor/handler/api_handler.dart';
import 'package:let_tutor/handler/auth/auth_controller.dart';

class CourseController {
  static const String _path = "course";
  static Future getListCourse() async {
    Response res = await ApiHandler.handler.get(
      baseUrl + _path,
      options: ApiHandler.getHeaders(),
      queryParameters: {"page": 1, "size": 100},
    );
    print(res.realUri.toString());

    if (res.statusCode == 200) {
      print(res.data);
    }
  }
}
