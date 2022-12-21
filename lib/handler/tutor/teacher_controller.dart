import 'package:dio/dio.dart';
import 'package:let_tutor/handler/api_handler.dart';
import 'package:let_tutor/models/teacher/teacher.dart';
import 'package:let_tutor/models/teacher/teacher_detail.dart';

class TeacherController {
  static const String _path = "tutor";

  static Future<List<Teacher>> getListTeacher(
      {int page = 1, int perPage = 24}) async {
    String requestUrl = "$baseUrl$_path/more";
    List<Teacher> teachers = [];
    Response respond = await ApiHandler.handler.get(
      requestUrl,
      options: ApiHandler.getHeaders(),
      queryParameters: {"page": page, "perPage": perPage},
    );
    if (respond.statusCode == 200) {
      var teacherData = respond.data['tutors']['rows'] as List<dynamic>;
      for (dynamic teacher in teacherData) {
        teachers.add(Teacher.fromJson(teacher));
      }
    }
    return teachers;
  }

  static Future<TeacherDetail> getTeacherDetail(String teacherID) async {
    String requestUrl = "$baseUrl$_path/$teacherID";
    Response respond = await ApiHandler.handler.get(
      requestUrl,
      options: ApiHandler.getHeaders(),
    );
    TeacherDetail td = TeacherDetail();
    if (respond.statusCode == 200) {
      td = TeacherDetail.fromJson(respond.data);
    }
    return td;
  }

  static Future<Map<String, dynamic>> searchTeacher({
    List<String> specialties = const [],
    int page = 1,
    int perPage = 12,
  }) async {
    List<Teacher> teachers = [];
    String requestUrl = "$baseUrl$_path/search";
    Map payload = {
      "filters": {
        "specialties": specialties,
        "date": null,
        "nationality": {},
        "tutoringTimeAvailable": [null, null]
      },
      "page": page,
      "perPage": perPage,
    };
    Response respond = await ApiHandler.handler.post(
      requestUrl,
      options: ApiHandler.getHeaders(),
      data: payload,
    );
    int count = 0;
    if (respond.statusCode == 200) {
      var data = respond.data;
      count = data['count'];
      var teacherList = data['rows'] as List<dynamic>;
      for (var teacher in teacherList) {
        teachers.add(Teacher.fromJson(teacher));
      }
    }
    return {
      "count": count,
      "teachers": teachers,
    };
  }

  static Future<void> addFavoriteTeacher(String teacherID) async {
    String requestUrl = "${baseUrl}user/manageFavoriteTutor";
    Response respond = await ApiHandler.handler.post(
      requestUrl,
      options: ApiHandler.getHeaders(),
      data: {"tutorId": teacherID},
    );
    if (respond.statusCode == 200) {
      print(respond.data);
    }
  }
}
