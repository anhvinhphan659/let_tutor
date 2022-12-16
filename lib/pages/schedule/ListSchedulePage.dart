import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/handler/course/course_controller.dart';
import 'package:let_tutor/handler/schedule/schedule_controller.dart';
import 'package:let_tutor/handler/user/user_controller.dart';
import 'package:let_tutor/models/course/study_progress.dart';
import 'package:let_tutor/models/schedule/booking_history.dart';

import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/schedule/ScheduleCard.dart';
import 'package:let_tutor/utils/styles/styles.dart';
import 'package:number_paginator/number_paginator.dart';

class ListSchedulePage extends StatefulWidget {
  const ListSchedulePage({Key? key}) : super(key: key);

  @override
  State<ListSchedulePage> createState() => _ListSchedulePageState();
}

class _ListSchedulePageState extends State<ListSchedulePage> {
  int pageCount = 1;
  int _currentPage = 1;
  static const int DEFAULT_PER_PAGE = 20;
  bool isLoading = true;
  List<BookingSchedule> listSchedules = [];

  int latestPage = 0;
  String fileName = "";
  String fileURL = "";

  @override
  void initState() {
    // TODO: implement initState
    updateListSchedule();
    super.initState();
  }

  void updateListSchedule({int page = 1, int perPage = DEFAULT_PER_PAGE}) {
    setState(() {
      isLoading = true;
    });

    CourseController.getLatestLearning(UserController.currentUser.id ?? "")
        .then((latestLearningDate) {
      if (latestLearningDate != null) {
        setState(() {
          latestPage = latestLearningDate.currentPage ?? 0;
          if (latestLearningDate.eBook != null) {
            fileName = latestLearningDate.eBook!.name ?? "";
            fileURL = latestLearningDate.eBook!.fileUrl ?? "";
          }
        });
      }
    });
    ScheduleController.getComingSchedule(
            page: page,
            perPage: perPage,
            dateTimeGte: DateTime.now()
                .subtract(const Duration(minutes: 32))
                .millisecondsSinceEpoch)
        .then((value) {
      List<BookingSchedule> bookingSchedule =
          value['bookedSchedule'] ?? <BookingSchedule>[];
      print("Booking History length: ${bookingSchedule.length}");
      setState(() {
        pageCount = value['count'] as int;
        print(pageCount);
        pageCount = (pageCount / DEFAULT_PER_PAGE).ceil();
        print(pageCount);
        listSchedules = bookingSchedule;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const LettutorAppBar(),
        body: Container(
          color: Colors.white,
          child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: SvgPicture.asset(
                    'assets/images/calendar_check.svg',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Text(
                  'Schedule',
                  style: LettutorFontStyles.h2Title,
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              color: Color.fromRGBO(100, 100, 100, 0.2),
                              width: 4))),
                  child: Text(
                    'Here is a list of the sessions you have booked\nYou can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours',
                    maxLines: 6,
                    style:
                        LettutorFontStyles.contentText.copyWith(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: Text(
                    'Latest Book',
                    style: LettutorFontStyles.normalText
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(50),
                    1: FlexColumnWidth(),
                    2: FixedColumnWidth(50),
                    3: FixedColumnWidth(50),
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
                        child: Center(child: Text("Name")),
                      ),
                      Center(
                        child: TextButton(
                          child: Text(fileName),
                          onPressed: () {
                            //TODO: show file URL
                            print("File URL: " + fileURL);
                          },
                        ),
                      ),
                      Container(
                        height: 70,
                        color: Color.fromRGBO(250, 250, 250, 1.0),
                        child: Center(child: Text('Page')),
                      ),
                      Text(latestPage > 0 ? latestPage.toString() : ""),
                    ]),
                    TableRow(children: [
                      Container(
                        color: Color.fromRGBO(250, 250, 250, 1.0),
                        height: 70,
                        child: Center(child: Text('Description')),
                      ),
                      Text(' '),
                      Text(' '),
                      Text(' '),
                    ])
                  ],
                ),
                isLoading
                    ? const SizedBox(
                        height: 350,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Column(
                        children: [
                          ...listSchedules.map(
                            (e) => ScheduleCard(
                              schedule: e,
                            ),
                          ),
                          listSchedules.isNotEmpty
                              ? NumberPaginator(
                                  numberPages: pageCount,
                                  initialPage: _currentPage - 1,
                                  onPageChange: (pageIndex) {
                                    setState(() {
                                      _currentPage = pageIndex + 1;
                                    });
                                    updateListSchedule(page: _currentPage);
                                  },
                                )
                              : Container(
                                  child: Column(children: [
                                    SizedBox(height: 150),
                                    Text("There is no lesson schedule yet!"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.checklist,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Book a lesson")
                                              ],
                                            )),
                                      ],
                                    )
                                  ]),
                                )
                        ],
                      ),
              ]),
        ));
  }
}
