import 'package:dio/dio.dart';
import 'package:let_tutor/handler/api_handler.dart';
import 'package:let_tutor/models/teacher/teacher.dart';
import 'package:let_tutor/models/teacher/teacher_detail.dart';

class TeacherController {
  static const String _path = "tutor/";

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
      print(respond.data);
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
}
