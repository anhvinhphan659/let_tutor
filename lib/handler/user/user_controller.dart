import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/handler/api_handler.dart';

import 'package:let_tutor/models/user.dart';

class UserController {
  static late User currentUser;

  static const String _userPath = "user";
  static const String _learnTopicPath = "learn-topic";
  static const String _testPrepartionPath = "test-preparation";

  static Future<bool> getUserInformation() async {
    bool result = true;
    String requestUrl = "$baseUrl$_userPath/info";
    Response respond = await ApiHandler.handler.get(
      requestUrl,
      options: ApiHandler.getHeaders(),
    );

    if (respond.statusCode == 200) {
      var data = respond.data;
      currentUser = User.fromJson(data["user"]);
      print(currentUser);
    }

    return result;
  }

  static Future<List<LearnTopics>> getAllLearnTopic() async {
    List<LearnTopics> topics = [];
    String requestUrl = "$baseUrl$_learnTopicPath";
    Response respond = await ApiHandler.handler.get(
      requestUrl,
    );
    try {
      if (respond.statusCode == 200) {
        var data = respond.data;
        for (var topic in data) {
          topics.add(LearnTopics.fromJson(topic));
        }
      }
    } catch (e) {
      // print(object)
    }

    return topics;
  }

  static Future<List<TestPreparations>> getAllTestPreparation() async {
    List<TestPreparations> res = [];
    String requestUrl = "$baseUrl$_testPrepartionPath";
    Response respond = await ApiHandler.handler.get(
      requestUrl,
    );
    if (respond.statusCode == 200) {
      var data = respond.data;
      for (var prepare in data) {
        res.add(TestPreparations.fromJson(prepare));
      }
    }
    return res;
  }

  static Future<bool> updatePersonalInformation(
    User user, {
    List<String> learnTopics = const [],
    List<String> testPreparations = const [],
  }) async {
    Map dataBody = {
      "name": user.name,
      "country": user.country,
      "phone": user.phone,
      "birthday": user.birthday,
      "level": user.level,
      "learnTopics": learnTopics,
      "testPreparations": testPreparations,
    };

    print(dataBody);
    //call api
    String requestUrl = "$baseUrl$_userPath/info";
    Response respond = await ApiHandler.handler.put(
      requestUrl,
      options: ApiHandler.getHeaders(),
      data: dataBody,
    );
    return respond.statusCode == 200;
    // return true;
  }
}
