import 'package:dio/dio.dart';
import 'package:let_tutor/models/schedule/schedule.dart';
import 'package:let_tutor/models/schedule/teacher_schedule.dart';

import '../api_handler.dart';

class ScheduleController {
  //?tutorId=4d54d3d7-d2a9-42e5-97a2-5ed38af5789a&startTimestamp=1670518800000&endTimestamp=1671123599999
  static const String _schedulePath = "schedule";
  static const String _bookingPath = "booking";
  static Future<List<TeacherSchedule>> getScheduleByTutor(String tutorID,
      {DateTime? startTime}) async {
    List<TeacherSchedule> ret = [];
    String requestUrl = "$baseUrl$_schedulePath";
    startTime ??= DateTime.now();
    startTime =
        DateTime(startTime.year, startTime.month, startTime.day, 0, 0, 0);
    int startTimeStamp = startTime.millisecondsSinceEpoch;
    int endTimeStamp =
        startTimeStamp + const Duration(days: 7).inMilliseconds - 1;
    try {
      Response respond = await ApiHandler.handler.get(
        requestUrl,
        options: ApiHandler.getHeaders(),
        queryParameters: {
          "tutorId": tutorID,
          "startTimestamp": startTimeStamp,
          "endTimestamp": endTimeStamp,
        },
      );

      print(respond.realUri);

      if (respond.statusCode == 200) {
        var data = respond.data['scheduleOfTutor'];
        for (var schedule in data) {
          ret.add(TeacherSchedule.fromJson(schedule));
        }
      }
    } catch (e) {
      //
    }
    return ret;
  }

  static Future<bool> bookAClass(
      List<String> scheduleDetailIds, String note) async {
    String requestUrl = "$baseUrl$_bookingPath";
    Response respond = await ApiHandler.handler.post(requestUrl,
        options: ApiHandler.getHeaders(),
        data: {"scheduleDetailIds": scheduleDetailIds, "note": note});
    if (respond.statusCode == 200) {
      return true;
    }
    return false;
  }
}
