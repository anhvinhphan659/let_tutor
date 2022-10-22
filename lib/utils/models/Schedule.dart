import 'package:let_tutor/utils/models/Teacher.dart';

class Schedule {
  String date;
  String startTime;
  String endTime;
  Teacher teacher;

  Schedule(
      {this.date = "",
      this.startTime = "",
      this.endTime = "",
      required this.teacher});
}
