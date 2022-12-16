import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/handler/schedule/schedule_controller.dart';
import 'package:let_tutor/models/schedule/booking_history.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/schedule/HistoryScheduleCard.dart';
import 'package:let_tutor/utils/styles/styles.dart';
import 'package:number_paginator/number_paginator.dart';

class HistorySchedulePage extends StatefulWidget {
  const HistorySchedulePage({Key? key}) : super(key: key);

  @override
  State<HistorySchedulePage> createState() => _HistorySchedulePageState();
}

class _HistorySchedulePageState extends State<HistorySchedulePage> {
  List<BookingSchedule> listSchedules = [];
  int pageCount = 1;
  int _currentPage = 1;
  static const int DEFAULT_PER_PAGE = 20;
  bool isLoading = true;

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
    ScheduleController.getBookingHistory(
            page: page,
            perPage: perPage,
            dateTimeLte: DateTime.now()
                .subtract(const Duration(minutes: 2))
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
              Container(
                width: 120,
                height: 120,
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(
                  'assets/images/history.svg',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Text(
                'History',
                style: LettutorFontStyles.h2Title,
              ),
              Container(
                padding: const EdgeInsets.only(left: 8.0),
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            color: Color.fromRGBO(100, 100, 100, 0.2),
                            width: 4))),
                child: Text(
                  'The following is a list of lessons you have attended\nYou can review the details of the lessons you have attended',
                  maxLines: 6,
                  style: LettutorFontStyles.contentText.copyWith(fontSize: 18),
                ),
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
                          (e) => HistoryScheduleCard(
                            schedule: e,
                          ),
                        ),
                        NumberPaginator(
                          numberPages: pageCount,
                          initialPage: _currentPage - 1,
                          onPageChange: (pageIndex) {
                            setState(() {
                              _currentPage = pageIndex + 1;
                            });
                            updateListSchedule(page: _currentPage);
                          },
                        )
                      ],
                    ),
            ]),
      ),
    );
  }
}
