import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import 'package:let_tutor/handler/schedule/schedule_controller.dart';
import 'package:let_tutor/handler/tutor/teacher_controller.dart';
import 'package:let_tutor/models/schedule/booking_history.dart';
import 'package:let_tutor/models/teacher/teacher.dart';
import 'package:let_tutor/pages/conference/VideoConference.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/SkillTag.dart';
import 'package:let_tutor/utils/components/teachers/TeacherCard.dart';

import 'package:let_tutor/utils/styles/styles.dart';
import 'package:let_tutor/utils/util_function.dart';
import 'package:number_paginator/number_paginator.dart';

import 'TeacherPagination.dart';

class ListTeacherPage extends StatefulWidget {
  const ListTeacherPage({Key? key}) : super(key: key);

  @override
  State<ListTeacherPage> createState() => _ListTeacherPageState();
}

class _ListTeacherPageState extends State<ListTeacherPage> {
  static const int PER_PAGE = 12;
  BookingSchedule? nextSchedule;
  var skills = [
    "All",
    "For Studing Abroad",
    "English for Kid",
    "English for Traveling",
    "Conversational English",
    "Business English",
    "STARTERS",
    "MOVERS",
    "FLYERS",
    "KET",
    "PET",
    "IELTS",
    "TOEFL",
    "TOEIC",
  ];
  int _selectedSkill = 0;
  bool isLoading = true;
  bool isTeacherLoading = true;
  var favoriteTecher = [];
  List<Teacher> teacherList = [];
  int pageCount = 1;
  int _currentPage = 1;

  int lessonTotalTime = 0;

  @override
  void initState() {
    super.initState();

    updateListTeacher();
    initPage();
  }

  void updateListTeacher() {
    TeacherController.searchTeacher(
      page: _currentPage,
      perPage: PER_PAGE,
    ).then((value) {
      int count = value['count'];
      List<Teacher> teachers = value['teachers'] ?? <Teacher>[];
      setState(() {
        pageCount = (count / PER_PAGE).ceil();
        teacherList = teachers;
        isTeacherLoading = false;
      });
      // print("Count: " + value['count'].toString());
      print("Teacher in respond: " +
          (value['teachers'] as List<Teacher>).length.toString());
    });
  }

  void sortListTeacher() {
    teacherList.sort(((a, b) {
      String aFavorite = a.isFavoriteTutor ?? "";
      String bFavorite = b.isFavoriteTutor ?? "";

      return bFavorite.compareTo(aFavorite);
    }));
  }

  Future<void> initPage() async {
    nextSchedule = await ScheduleController.getNextLesson();
    lessonTotalTime = await ScheduleController.getLessonTotalTime();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasLesson = nextSchedule != null;
    if (hasLesson) {
      //check lesson pass
      if (DateTime.now().millisecondsSinceEpoch >
          (nextSchedule!.scheduleDetailInfo!.endPeriodTimestamp ?? 0)) {
        hasLesson = false;
      }
    }
    sortListTeacher();
    return Scaffold(
        appBar: const LettutorAppBar(),
        body: isLoading
            ? Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: const RefreshProgressIndicator(),
              )
            : ListView(
                children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(12, 61, 223, 1),
                        Color.fromRGBO(5, 23, 157, 1),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          child: Text(
                            hasLesson
                                ? 'Upcoming lesson'
                                : 'You have no upcoming lesson.',
                            style: LettutorFontStyles.nextLessonText.copyWith(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        hasLesson
                            ? const SizedBox()
                            : Text(
                                "Welcome to LetTutor!",
                                style:
                                    LettutorFontStyles.nextLessonText.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                        hasLesson
                            ? Row(
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width /
                                                2),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${DateFormat("EEE, d MMM yy HH:mm").format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                nextSchedule!
                                                        .scheduleDetailInfo!
                                                        .startPeriodTimestamp ??
                                                    0),
                                          )} - ${convertTimeStampToHour(nextSchedule!.scheduleDetailInfo!.endPeriodTimestamp ?? 0)}",
                                          style: LettutorFontStyles
                                              .nextLessonText
                                              .copyWith(
                                            fontSize: 20,
                                          ),
                                        ),
                                        CountdownTimer(
                                          endTime: nextSchedule!
                                                  .scheduleDetailInfo!
                                                  .endPeriodTimestamp ??
                                              0 -
                                                  DateTime.now()
                                                      .microsecondsSinceEpoch,
                                          widgetBuilder: (context, time) {
                                            if (time == null) {
                                              return Text("");
                                            }
                                            String timeString = (time!.hours ??
                                                        0) <
                                                    10
                                                ? "0${time.hours}"
                                                : "${time.hours}:${(time.min ?? 0) < 10 ? "0${time.min}" : "${time.min}"}:${(time.sec ?? 0) < 10 ? "0${time.sec}" : "${time.sec}"}";
                                            return Text(
                                              "(start in $timeString)",
                                              style: LettutorFontStyles
                                                  .nextLessonText
                                                  .copyWith(
                                                      color: Colors.yellow),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print(nextSchedule!.studentMeetingLink ??
                                          "");
                                      PushTo(
                                          context: context,
                                          destination: VideoConferencePage(
                                            meetingLink: nextSchedule!
                                                    .studentMeetingLink ??
                                                "",
                                          ));
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 6.4),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: SvgPicture.asset(
                                                'assets/icons/youtube.svg',
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                            Text('Enter Lesson Room')
                                          ],
                                        )),
                                  )
                                ],
                              )
                            : const SizedBox(
                                height: 20,
                              ),
                        hasLesson
                            ? Text(
                                'Total lesson time is ${(lessonTotalTime / 60).floor()} hours ${lessonTotalTime % 60} minutes',
                                style:
                                    LettutorFontStyles.nextLessonText.copyWith(
                                  fontSize: 16,
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 33, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "Find a tutor",
                            style: LettutorFontStyles.searchTitle,
                          ),
                        ),
                        Wrap(
                          children: [
                            Container(
                              width: 200,
                              margin: EdgeInsets.only(right: 5.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Enter tutor name...",
                                  hintStyle: LettutorFontStyles.hintText,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10.0),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(217, 217, 217, 1.0),
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: const BorderSide(
                                      color: Color.fromRGBO(64, 169, 255, 1.0),
                                    ),
                                  ),
                                  // disabledBorder: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(50),
                                  //   borderSide: const BorderSide(
                                  //       color: Color.fromRGBO(217, 217, 217, 1.0)),
                                  // ),
                                ),
                              ),
                            ),
                            Container(
                                width: 250,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 1.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Color.fromRGBO(217, 217, 217, 1.0),
                                    )),
                                child: GFMultiSelect(
                                    size: 15,
                                    dropdownTitleTilePadding: EdgeInsets.zero,
                                    dropdownTitleTileText:
                                        "Select tutor nationality",
                                    dropdownUnderlineBorder:
                                        BorderSide(width: 0),
                                    dropdownTitleTileMargin:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    hideDropdownUnderline: true,
                                    dropdownTitleTileHintTextStyle:
                                        LettutorFontStyles.hintText,
                                    dropdownTitleTileTextStyle:
                                        LettutorFontStyles.hintText,
                                    items: const [
                                      "Foreign Tutor",
                                      "Vietnamese Tutor",
                                      "Native English Tutor",
                                    ],
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 4.0),
                                    margin: EdgeInsets.zero,
                                    onSelect: ((value) => print(value)))),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Select available tutoring time:',
                            style: LettutorFontStyles.searchTitle
                                .copyWith(fontSize: 14),
                          ),
                        ),
                        Wrap(
                          children: [
                            Container(
                              width: 125,
                              child: TextField(
                                  decoration: InputDecoration(
                                hintText: "Select a day",
                                hintStyle: LettutorFontStyles.hintText,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10.0),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(217, 217, 217, 1.0),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(64, 169, 255, 1.0),
                                  ),
                                ),
                              )),
                            ),
                            Container(
                              width: 125,
                              decoration: BoxDecoration(),
                              child: TextField(
                                  decoration: InputDecoration(
                                hintText: "Start time ...",
                                hintStyle: LettutorFontStyles.hintText,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10.0),
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(217, 217, 217, 1.0),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(64, 169, 255, 1.0),
                                  ),
                                ),
                              )),
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            ...List.generate(
                              skills.length,
                              (index) => GestureDetector(
                                child: SkillTag(
                                  skill: skills[index],
                                  selected: index == _selectedSkill,
                                ),
                                onTap: () {
                                  setState(() {
                                    _selectedSkill = index;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSkill = 0;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: LettutorColors.lightBlueColor),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              'Reset Filters',
                              style:
                                  LettutorFontStyles.descriptionText.copyWith(
                                color: LettutorColors.lightBlueColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      isTeacherLoading
                          ? const CircularProgressIndicator()
                          : const SizedBox(),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: isTeacherLoading ? 0.2 : 1.0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 33),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recommended Tutors',
                                style: LettutorFontStyles.searchTitle.copyWith(
                                  fontSize: 25,
                                ),
                              ),
                              // Text("List gia sư"),
                              ...List.generate(
                                  teacherList.length,
                                  (index) => TeacherCard(
                                        teacher: teacherList[index],
                                        onFavoriteTap: () async {
                                          var teacher = teacherList[index];
                                          setState(() {
                                            if (teacher.isFavoriteTutor !=
                                                null) {
                                              teacherList[index]
                                                  .isFavoriteTutor = null;
                                            } else {
                                              teacherList[index]
                                                  .isFavoriteTutor = "1";
                                            }
                                            sortListTeacher();
                                          });

                                          TeacherController.addFavoriteTeacher(
                                              teacher.id ?? "");
                                          // updateListTeacher();
                                        },
                                      )),
                              NumberPaginator(
                                numberPages: pageCount,
                                initialPage: _currentPage - 1,
                                onPageChange: (pageIndex) {
                                  setState(() {
                                    _currentPage = pageIndex + 1;
                                    isTeacherLoading = true;
                                  });
                                  updateListTeacher();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ));
  }
}
