import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:let_tutor/handler/api_handler.dart';
import 'package:let_tutor/handler/auth/auth_controller.dart';
import 'package:let_tutor/models/category.dart';
import 'package:let_tutor/models/course/content_category.dart';
import 'package:let_tutor/models/course/course.dart';
import 'package:let_tutor/models/course/course_detail.dart';
import 'package:let_tutor/models/course/e_book.dart';
import 'package:let_tutor/models/course/study_progress.dart';
import 'package:let_tutor/utils/components/courses/CourseCard.dart';
import 'package:let_tutor/utils/components/courses/EbookCard.dart';
import 'package:let_tutor/utils/styles/styles.dart';

class CourseController {
  static const String _coursePath = "course";
  static const String _ebookPath = "e-book";
  static Future<List<Course>> getListCourse({
    int page = 1,
    int perPage = 100,
    List<int>? level,
    String? order,
    String? orderBy,
    List<String>? categoryId,
    String? q,
  }) async {
    String requestUrl = "$baseUrl$_coursePath";
    List<Course> courses = [];

    Map<String, dynamic> queryParams = {
      "page": page,
      "size": perPage,
      // "level[]": level,
      // "order[]": "level",
      // "orderBy[]": orderBy,
      // "categoryId[]": categoryId,
      // "q": q,
    };
    if (level != null) {
      queryParams["level[]"] = level;
    }
    // if (order != null) {
    //   queryParams["order[]"] = order;
    // }
    if (orderBy != null) {
      queryParams["orderBy[]"] = orderBy;
    }
    if (categoryId != null) {
      queryParams["categoryId[]"] = categoryId;
    }
    if (q != null) {
      queryParams["q"] = q;
    }

    Response respond = await ApiHandler.handler.get(
      requestUrl,
      options: ApiHandler.getHeaders(),
      queryParameters: queryParams,
    );
    print(queryParams);

    if (respond.statusCode == 200) {
      print(respond.data);
      var courseData = respond.data['data']['rows'] as List<dynamic>;
      for (dynamic course in courseData) {
        courses.add(Course.fromJson(course));
      }
    }
    return courses;
  }

  static List<Widget> getCourseCardsFromList(List<Course> courses) {
    List<Widget> res = [];
    Map<String, List<Course>> courseMap = {};
    for (int i = 0; i < courses.length; i++) {
      Course course = courses[i];
      if (course.categories != null) {
        for (var category in course.categories!) {
          if (courseMap[category.title!] == null) {
            courseMap[category.title!] = [course];
          } else {
            courseMap[category.title!]!.add(course);
          }
        }
      }
    }
    for (var category in courseMap.keys) {
      res.add(Text(
        category,
        style: LettutorFontStyles.h1Title,
      ));
      List<Course> courseByCategory = courseMap[category] ?? [];
      for (var course in courseByCategory) {
        res.add(CourseCard(course: course));
      }
    }
    print(courseMap);
    return res;
  }

  static Future<Map<String, dynamic>> getListEBook(
      {int page = 1,
      int perPage = 100,
      List<int>? level,
      String? order,
      String? orderBy,
      List<String>? categoryId,
      String? q}) async {
    String requestUrl = "$baseUrl$_ebookPath";
    List<EBook> ebooks = [];
    int count = 0;
    Map<String, dynamic> queryParams = {
      "page": page,
      "size": perPage,
      // "level[]": level,
      "order[]": "level",
      // "orderBy[]": orderBy,
      // "categoryId[]": categoryId,
      // "q": q,
    };
    Response respond = await ApiHandler.handler.get(
      requestUrl,
      options: ApiHandler.getHeaders(),
      queryParameters: queryParams,
    );
    if (level != null) {
      queryParams["level[]"] = level;
    }
    // if (order != null) {
    //   queryParams["order[]"] = order;
    // }
    if (orderBy != null) {
      queryParams["orderBy[]"] = orderBy;
    }
    if (categoryId != null) {
      queryParams["categoryId[]"] = categoryId;
    }
    if (q != null) {
      queryParams["q"] = q;
    }
    print(queryParams);
    if (respond.statusCode == 200) {
      print(respond.data);
      count = respond.data['data']['count'];
      var bookData = respond.data['data']['rows'] as List<dynamic>;
      for (dynamic book in bookData) {
        ebooks.add(EBook.fromJson(book));
      }
    }

    return {
      "count": count,
      "e-books": ebooks,
    };
  }

  static List<Widget> getEbookCardsFromList(List<EBook> ebooks) {
    List<Widget> res = [];

    Map<String, List<Widget>> ebooksMap = {};

    for (var ebook in ebooks) {
      EBookCard card = EBookCard(ebook: ebook);
      if (ebooksMap[ebook.level!] == null) {
        ebooksMap[ebook.level!] = [card];
      } else {
        ebooksMap[ebook.level!]!.add(card);
      }
    }

    for (var key in ebooksMap.keys) {
      res.addAll(ebooksMap[key]!);
    }
    return res;
  }

  static Future<LatestLearningDate?> getLatestLearning(String userID) async {
    String requestUrl = "$baseUrl$_ebookPath/$userID/learning-progress";
    LatestLearningDate? res;
    Response respond = await ApiHandler.handler.get(
      requestUrl,
      options: ApiHandler.getHeaders(),
    );

    if (respond.statusCode == 200) {
      var data = respond.data;
      StudyProgress sp = StudyProgress.fromJson(data['data']);
      if (sp.latestLearningDate != null) {
        return sp.latestLearningDate![0];
      }
    }

    return null;
  }

  static Future<CourseDetail?> getCourseDetailByID(String courseID) async {
    String requestUrl = "$baseUrl$_coursePath/$courseID";

    Response respond = await ApiHandler.handler.get(
      requestUrl,
      options: ApiHandler.getHeaders(),
    );
    if (respond.statusCode == 200) {
      var data = respond.data;
      return CourseDetail.fromJson(data['data']);
    }
    return null;
  }

  static Future<List<ContentCategory>> getAllContentCategory() async {
    String requestUrl = "${baseUrl}content-category";
    List<ContentCategory> categories = <ContentCategory>[];
    Response respond = await ApiHandler.handler.get(
      requestUrl,
      options: ApiHandler.getHeaders(),
    );
    if (respond.statusCode == 200) {
      var data = respond.data;
      for (var row in data["rows"]) {
        categories.add(ContentCategory.fromJson(row));
      }
    }

    return categories;
  }
}
