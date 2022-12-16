import 'package:dio/dio.dart';
import 'package:let_tutor/models/schedule/booking_history.dart';
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

  //Pass 35 minutes ago to get list studied class
  //5 minutes to get list ongoing upcoming class
  static Future<Map<String, dynamic>> getBookingHistory(
      {int page = 1,
      int perPage = 20,
      required int dateTimeLte,
      String orderBy = "meeting",
      String sortBy = "desc"}) async {
    List<BookingSchedule> bookedSchedule = [];
    String requestUrl = "$baseUrl$_bookingPath/list/student";
    //booking/list/student?page=1&perPage=20&dateTimeLte=1639805436469&orderBy=meeting&sortBy=desc

    var queryParams = {
      "page": page,
      "perPage": perPage,
      "dateTimeLte": dateTimeLte,
      "orderBy": orderBy,
      "sortBy": sortBy
    };
    Response respond = await ApiHandler.handler.request(
      requestUrl,
      queryParameters: queryParams,
      options: ApiHandler.getHeaders().copyWith(method: "GET"),
      data: {"tutorId": ""},
    );
    int count = 0;
    if (respond.statusCode == 200) {
      var data = respond.data['data'];

      count = data['count'] as int;
      for (var row in data['rows']) {
        try {
          BookingSchedule bookingHistory = BookingSchedule.fromJson(row);

          bookedSchedule.add(bookingHistory);
        } catch (e) {
          Map d = row as Map;
          for (var k in d.keys) {
            if (k.toString().contains("MeetingLink")) {
              continue;
            }
            print(k + ":" + d[k]);
          }
        }
      }
    }
    return {"count": count, "bookedSchedule": bookedSchedule};
  }

  static Future<Map<String, dynamic>> getComingSchedule(
      {int page = 1,
      int perPage = 20,
      required int dateTimeGte,
      String orderBy = "meeting",
      String sortBy = "asc"}) async {
    List<BookingSchedule> bookedSchedule = [];
    String requestUrl = "$baseUrl$_bookingPath/list/student";
    //booking/list/student?page=1&perPage=20&dateTimeLte=1639805436469&orderBy=meeting&sortBy=desc

    var queryParams = {
      "page": page,
      "perPage": perPage,
      "dateTimeGte": dateTimeGte,
      "orderBy": orderBy,
      "sortBy": sortBy
    };
    Response respond = await ApiHandler.handler.request(
      requestUrl,
      queryParameters: queryParams,
      options: ApiHandler.getHeaders().copyWith(method: "GET"),
      data: {"tutorId": ""},
    );
    int count = 0;
    if (respond.statusCode == 200) {
      var data = respond.data['data'];

      count = data['count'] as int;
      for (var row in data['rows']) {
        try {
          BookingSchedule bookingHistory = BookingSchedule.fromJson(row);

          bookedSchedule.add(bookingHistory);
        } catch (e) {
          Map d = row as Map;
          for (var k in d.keys) {
            if (k.toString().contains("MeetingLink")) {
              continue;
            }
            print(k + ":" + d[k]);
          }
        }
      }
    }
    return {"count": count, "bookedSchedule": bookedSchedule};
  }

  static Future<BookingSchedule?> getNextLesson() async {
    BookingSchedule? schedule;
    String requestUrl = "$baseUrl$_bookingPath/next";
    var queryParams = {
      "dateTime": DateTime.now().millisecondsSinceEpoch,
    };
    Response respond = await ApiHandler.handler.get(
      requestUrl,
      queryParameters: queryParams,
      options: ApiHandler.getHeaders(),
    );
    if (respond.statusCode == 200) {
      var data = respond.data['data'] as List<dynamic>;
      if (data.isNotEmpty) {
        schedule = BookingSchedule.fromJson(data[0]);
      }
    }
    return schedule;
  }

  static Future<int> getLessonTotalTime() async {
    String requestUrl = "${baseUrl}call/total";
    Response respond = await ApiHandler.handler.get(
      requestUrl,
      options: ApiHandler.getHeaders(),
    );

    if (respond.statusCode == 200) {
      return respond.data['total'] as int;
    }
    return 0;
  }
}
