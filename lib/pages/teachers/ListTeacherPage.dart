import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import 'package:let_tutor/handler/schedule/schedule_controller.dart';
import 'package:let_tutor/handler/tutor/teacher_controller.dart';
import 'package:let_tutor/models/schedule/booking_history.dart';
import 'package:let_tutor/models/user.dart';
import 'package:let_tutor/models/teacher/teacher.dart';
import 'package:let_tutor/pages/conference/VideoConference.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/SkillTag.dart';
import 'package:let_tutor/utils/components/teachers/TeacherCard.dart';
import 'package:let_tutor/utils/data/util_storage.dart';

import 'package:let_tutor/utils/styles/styles.dart';
import 'package:let_tutor/utils/util_function.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:number_paginator/number_paginator.dart';

import 'TeacherPagination.dart';

class ListTeacherPage extends StatefulWidget {
  const ListTeacherPage({Key? key}) : super(key: key);

  @override
  State<ListTeacherPage> createState() => _ListTeacherPageState();
}

class _ListTeacherPageState extends State<ListTeacherPage> {
  // ignore: constant_identifier_names
  static const int PER_PAGE = 12;
  BookingSchedule? nextSchedule;

  var skills = <LearnTopics>[
    LearnTopics(id: 0, key: "", name: "All"),
    ...UtilStorage.learnTopics,
    ...UtilStorage.testPreparations,
  ];
  int _selectedSkill = 0;
  bool isLoading = true;
  bool isTeacherLoading = true;
  var favoriteTecher = [];
  List<Teacher> teacherList = [];
  int pageCount = 1;
  int _currentPage = 1;

  final TextEditingController _selectDayTextController =
      TextEditingController();
  final TextEditingController _selectStartTimeController =
      TextEditingController();
  final TextEditingController _selectEndTimeController =
      TextEditingController();

  int lessonTotalTime = 0;

  @override
  void initState() {
    super.initState();

    updateListTeacher();
    initPage();
  }

  //search teacher variable
  DateTime? startPickedTime;
  DateTime? endPickedTime;
  List<String> specialties = [];
  DateTime? tutorDatePicked;
  String? date;
  Map<String, bool> nationality = {};
  List<int?> tutoringTimeAvailable = const [null, null];
  String searchName = "";

//check picked datetime for converting to data
  bool checkTimeSelection() {
    if (tutorDatePicked != null) {
      //if tutor date is picked
      date = tutorDatePicked.toString();
      tutoringTimeAvailable = [
        DateTime(tutorDatePicked!.year, tutorDatePicked!.month,
                tutorDatePicked!.day, 0, 0)
            .millisecondsSinceEpoch,
        DateTime(tutorDatePicked!.year, tutorDatePicked!.month,
                tutorDatePicked!.day, 23, 59)
            .millisecondsSinceEpoch
      ];
      if (startPickedTime != null && endPickedTime != null) {
        var startTime = DateTime(
            tutorDatePicked!.year,
            tutorDatePicked!.month,
            tutorDatePicked!.day,
            startPickedTime!.hour,
            startPickedTime!.minute);
        var endTime = DateTime(tutorDatePicked!.year, tutorDatePicked!.month,
            tutorDatePicked!.day, endPickedTime!.hour, endPickedTime!.minute);
        tutoringTimeAvailable = [
          startTime.millisecondsSinceEpoch,
          endTime.millisecondsSinceEpoch
        ];
      }

      return true;
    } else {
      date = null;
      tutoringTimeAvailable = [null, null];
    }
    return false;
  }

  void updateListTeacher() {
    TeacherController.searchTeacher(
      specialties: specialties,
      date: date,
      page: _currentPage,
      perPage: PER_PAGE,
      nationality: nationality,
      tutoringTimeAvailable: tutoringTimeAvailable,
      search: searchName,
    ).then((value) {
      int count = value['count'];
      List<Teacher> teachers = value['teachers'] ?? <Teacher>[];
      setState(() {
        pageCount = (count / PER_PAGE).ceil();
        teacherList = teachers;
        isTeacherLoading = false;
      });
      // print("Count: " + value['count'].toString());
      // print("Teacher in respond: " +
      //     (value['teachers'] as List<Teacher>).length.toString());
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
    //prevent back after sign in
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                        gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(12, 61, 223, 1),
                              Color.fromRGBO(5, 23, 157, 1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
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
                                  style: LettutorFontStyles.nextLessonText
                                      .copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                          hasLesson
                              ? Row(
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
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
                                              int hh = time.hours ?? 0;
                                              int mm = time.min ?? 0;
                                              int ss = time.sec ?? 0;

                                              String timeString = "";
                                              if (hh < 10) {
                                                timeString += "0$hh";
                                              } else {
                                                timeString += hh.toString();
                                              }
                                              if (mm < 10) {
                                                timeString += ":0$mm";
                                              } else {
                                                timeString += ":$mm";
                                              }
                                              if (ss < 10) {
                                                timeString += ":0$ss";
                                              } else {
                                                timeString += ":$ss";
                                              }
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
                                        print(
                                            nextSchedule!.studentMeetingLink ??
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
                                  style: LettutorFontStyles.nextLessonText
                                      .copyWith(
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
                                margin: const EdgeInsets.only(
                                    right: 5.0, bottom: 10),
                                child: TextField(
                                  onSubmitted: (value) {
                                    setState(() {
                                      searchName = value;
                                      updateListTeacher();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Enter tutor name...",
                                    hintStyle: LettutorFontStyles.hintText,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10.0),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: const BorderSide(
                                        color:
                                            Color.fromRGBO(217, 217, 217, 1.0),
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: const BorderSide(
                                        color:
                                            Color.fromRGBO(64, 169, 255, 1.0),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 1.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Color.fromRGBO(217, 217, 217, 1.0),
                                    )),
                                child: MultiSelectDialogField(
                                  buttonText: Text("Select tutor nationality"),
                                  title: Text("Select tutor nationality"),
                                  items: [
                                    MultiSelectItem("foreign", "Foreign Tutor"),
                                    MultiSelectItem(
                                        "isVietNamese", "Vietnamese Tutor"),
                                    MultiSelectItem(
                                        "isNative", "Native English Tutor"),
                                  ],
                                  onConfirm: (value) {
                                    Map<String, bool> nationMap = {};
                                    if (value.contains("foreign")) {
                                      if (value.length == 3) {
                                        nationMap = {};
                                      } else {
                                        if (value.contains("isNative")) {
                                          nationMap = {"isVietNamese": false};
                                        } else {
                                          nationMap = {"isNative": false};
                                        }
                                      }
                                    } else {
                                      for (var val in value) {
                                        nationMap[val] = true;
                                      }
                                    }

                                    setState(() {
                                      nationality = nationMap;
                                    });
                                    updateListTeacher();
                                  },
                                ),
                              ),
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
                                margin: const EdgeInsets.only(bottom: 10),
                                width: 200,
                                child: TextField(
                                  onTap: () async {
                                    await setDatePicked();
                                    if (checkTimeSelection()) {
                                      print(startPickedTime);
                                      updateListTeacher();
                                    }
                                  },
                                  controller: _selectDayTextController,
                                  decoration: InputDecoration(
                                      hintText: "Select a day",
                                      hintStyle: LettutorFontStyles.hintText,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5.0),
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(
                                              217, 217, 217, 1.0),
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(64, 169, 255, 1.0),
                                        ),
                                      ),
                                      suffixIcon: tutorDatePicked != null
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  tutorDatePicked = null;
                                                  _selectDayTextController
                                                      .text = "";
                                                  //update date DATA
                                                  checkTimeSelection();
                                                  updateListTeacher();
                                                });
                                              },
                                              child: const Icon(Icons.cancel))
                                          : GestureDetector(
                                              onTap: () async {
                                                await setDatePicked();
                                              },
                                              child: const Icon(
                                                Icons.calendar_today,
                                                size: 16,
                                              ))),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromRGBO(217, 217, 217, 1.0),
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(top: 4),
                                      width: 100,
                                      height: 40,
                                      child: GestureDetector(
                                        onTap: () async {
                                          startPickedTime =
                                              await showTimePickerSpinner(
                                                  context);
                                          if (checkTimeSelection()) {
                                            print(tutorDatePicked);
                                            updateListTeacher();
                                          }
                                          setState(() {
                                            if (startPickedTime != null) {
                                              _selectStartTimeController.text =
                                                  DateFormat("HH:mm")
                                                      .format(startPickedTime!);
                                            }
                                          });
                                        },
                                        child: TextField(
                                          enabled: false,
                                          controller:
                                              _selectStartTimeController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Start time",
                                            hintStyle:
                                                LettutorFontStyles.hintText,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5.0),
                                            isDense: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.trending_flat),
                                    Container(
                                      padding: const EdgeInsets.only(top: 4),
                                      width: 80,
                                      height: 40,
                                      child: GestureDetector(
                                        onTap: () async {
                                          endPickedTime =
                                              await showTimePickerSpinner(
                                                  context);
                                          if (checkTimeSelection()) {
                                            print(tutorDatePicked);
                                            updateListTeacher();
                                          }
                                          setState(() {
                                            if (endPickedTime != null) {
                                              _selectEndTimeController.text =
                                                  DateFormat("HH:mm")
                                                      .format(endPickedTime!);
                                            }
                                          });
                                        },
                                        child: TextField(
                                          controller: _selectEndTimeController,
                                          enabled: false,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "End time",
                                            hintStyle:
                                                LettutorFontStyles.hintText,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5.0),
                                            isDense: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                    (startPickedTime != null &&
                                            endPickedTime != null)
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                startPickedTime = null;
                                                endPickedTime = null;
                                                _selectStartTimeController
                                                    .clear();
                                                _selectEndTimeController
                                                    .clear();
                                                //update date data
                                                checkTimeSelection();
                                                updateListTeacher();
                                              });
                                            },
                                            child: Icon(Icons.cancel),
                                          )
                                        : const Icon(
                                            Icons.access_alarm,
                                            size: 15,
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              ...List.generate(
                                skills.length,
                                (index) => GestureDetector(
                                  child: SkillTag(
                                    skill: skills[index].name ?? "",
                                    selected: index == _selectedSkill,
                                  ),
                                  onTap: () {
                                    specialties = [];
                                    String selectedSkill =
                                        skills[index].name ?? "";
                                    setState(() {
                                      _selectedSkill = index;
                                    });
                                    if (selectedSkill.isNotEmpty) {
                                      specialties.add(skills[index].key ?? "");
                                      updateListTeacher();
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              specialties.clear();
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
                                  style:
                                      LettutorFontStyles.searchTitle.copyWith(
                                    fontSize: 25,
                                  ),
                                ),
                                // Text("List gia s??"),
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

                                            TeacherController
                                                .addFavoriteTeacher(
                                                    teacher.userId ?? "");
                                            // updateListTeacher();
                                          },
                                        )),
                                pageCount > 0
                                    ? NumberPaginator(
                                        numberPages: pageCount,
                                        initialPage: _currentPage - 1,
                                        onPageChange: (pageIndex) {
                                          setState(() {
                                            _currentPage = pageIndex + 1;
                                            isTeacherLoading = true;
                                          });
                                          updateListTeacher();
                                        },
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          SizedBox(
                                            height: 100,
                                          ),
                                          Text(
                                              "Sorry we can't find any tutor with this keywords"),
                                          SizedBox(
                                            height: 100,
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
    );
  }

  Future<void> setDatePicked() async {
    tutorDatePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365 * 20),
      ),
    );
    setState(() {
      if (tutorDatePicked != null) {
        _selectDayTextController.text =
            DateFormat("y-M-d").format(tutorDatePicked!);
      } else {
        _selectDayTextController.text = "";
      }
    });
  }
}
