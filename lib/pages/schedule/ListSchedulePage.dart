import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/schedule/ScheduleCard.dart';
import 'package:let_tutor/utils/models/Schedule.dart';
import 'package:let_tutor/utils/models/Teacher.dart';

class ListSchedulePage extends StatefulWidget {
  const ListSchedulePage({Key? key}) : super(key: key);

  @override
  State<ListSchedulePage> createState() => _ListSchedulePageState();
}

class _ListSchedulePageState extends State<ListSchedulePage> {
  var listSchedules = [
    Schedule(
        teacher: sampleTeachers[0],
        date: 'Sat, 22 Oct 22',
        startTime: '02:00',
        endTime: '02:25')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LettutorAppBar(),
        body: Container(
          color: Colors.white,
          child: ListView(children: [
            SizedBox(
              width: 120,
              height: 120,
              child: SvgPicture.asset(
                'assets/images/calendar_check.svg',
                fit: BoxFit.fitHeight,
              ),
            ),
            Text('Schedule'),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: Color.fromRGBO(100, 100, 100, 0.2),
                          width: 4))),
              child: Text(
                'Here is a list of the sessions you have booked\nYou can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours',
                maxLines: 6,
              ),
            ),
            Text('Latest Book'),
            Table(
              columnWidths: {
                0: FixedColumnWidth(150),
                1: FixedColumnWidth(50),
                2: FixedColumnWidth(80),
                3: FlexColumnWidth(),
              },
              border: TableBorder.all(
                  color: const Color.fromRGBO(
                    240,
                    240,
                    240,
                    1.0,
                  ),
                  width: 1.0),
              children: [
                TableRow(children: [
                  Container(
                    color: Color.fromRGBO(250, 250, 250, 1.0),
                    height: 70,
                    child: Text('Name'),
                  ),
                  Text(''),
                  Container(
                    height: 70,
                    color: Color.fromRGBO(250, 250, 250, 1.0),
                    child: Text('Page'),
                  ),
                  Text('0')
                ]),
                TableRow(children: [
                  Container(
                    color: Color.fromRGBO(250, 250, 250, 1.0),
                    height: 70,
                    child: Text('Description'),
                  ),
                  Text(' '),
                  Text(' '),
                  Text(' '),
                ])
              ],
            ),
            ...listSchedules.map(
              (e) => ScheduleCard(schedule: e),
            ),
          ]),
        ));
  }
}
