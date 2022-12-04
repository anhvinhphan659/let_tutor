import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:let_tutor/handler/api_handler.dart';
import 'package:let_tutor/handler/auth/auth_controller.dart';
import 'package:let_tutor/models/category.dart';
import 'package:let_tutor/models/course.dart';
import 'package:let_tutor/utils/components/courses/CourseCard.dart';

class CourseController {
  static const String _path = "course";
  static Future<List<Course>> getListCourse(
      {int page = 1, int perPage = 100}) async {
    String requestUrl = "$baseUrl$_path";
    List<Course> teachers = [];
    Response respond = await ApiHandler.handler.get(
      requestUrl,
      options: ApiHandler.getHeaders(),
      queryParameters: {"page": page, "perPage": perPage},
    );
    if (respond.statusCode == 200) {
      print(respond.data);
      var teacherData = respond.data['data']['rows'] as List<dynamic>;
      for (dynamic teacher in teacherData) {
        teachers.add(Course.fromJson(teacher));
      }
    }
    return teachers;
  }

  static List<Widget> getWidgetsFromList(List<Course> courses) {
    List<Widget> res = [];
    Map<String, List<Course>> courseMap = {};
    for (int i = 0; i < courses.length; i++) {
      Course course = courses[i];
      if (course.categories != null) {
        for (var category in course.categories!) {
          courseMap[category.title!] = courses;
        }
      }
    }
    for (var category in courseMap.keys) {
      res.add(Text(category));
      List<Course> courseByCategory = courseMap[category] ?? [];
      for (var course in courseByCategory) {
        res.add(CourseCard(course: course));
      }
    }
    print(courseMap);
    return res;
  }
}
