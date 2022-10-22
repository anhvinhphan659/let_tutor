import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/schedule/HistoryScheduleCard.dart';
import 'package:let_tutor/utils/models/Schedule.dart';
import 'package:let_tutor/utils/models/Teacher.dart';

class HistorySchedulePage extends StatefulWidget {
  const HistorySchedulePage({Key? key}) : super(key: key);

  @override
  State<HistorySchedulePage> createState() => _HistorySchedulePageState();
}

class _HistorySchedulePageState extends State<HistorySchedulePage> {
  var listSchedules = [
    Schedule(
        teacher: sampleTeachers[0],
        date: 'Thu, 30 Sep 21',
        startTime: '00:00',
        endTime: '00:30'),
    Schedule(
        teacher: sampleTeachers[0],
        date: 'Sat, 25 Sep 21',
        startTime: '20:00',
        endTime: '20:30'),
    Schedule(
        teacher: sampleTeachers[0],
        date: 'Thu, 23 Sep 21',
        startTime: '21:00',
        endTime: '21:30'),
    Schedule(
        teacher: sampleTeachers[0],
        date: 'Wed, 22 Sep 21',
        startTime: '00:00',
        endTime: '00:30'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginAppBar(context),
      body: Container(
        color: Colors.white,
        child: ListView(children: [
          SizedBox(
            width: 120,
            height: 120,
            child: SvgPicture.asset(
              'assets/images/history.svg',
              fit: BoxFit.fitHeight,
            ),
          ),
          Text('Schedule'),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                        color: Color.fromRGBO(100, 100, 100, 0.2), width: 4))),
            child: Text(
              'The following is a list of lessons you have attended\nYou can review the details of the lessons you have attended',
              maxLines: 6,
            ),
          ),
          ...listSchedules.map((e) => HistoryScheduleCard(
                schedule: e,
              )),
        ]),
      ),
    );
  }
}
