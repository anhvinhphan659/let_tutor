import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/getwidget.dart';

import 'package:let_tutor/handler/course/course_controller.dart';
import 'package:let_tutor/handler/tutor/teacher_controller.dart';
import 'package:let_tutor/models/teacher/teacher.dart';
import 'package:let_tutor/pages/conference/VideoConference.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/SkillTag.dart';
import 'package:let_tutor/utils/components/teachers/TeacherCard.dart';

import 'package:let_tutor/utils/styles/styles.dart';

import 'TeacherPagination.dart';

class ListTeacherPage extends StatefulWidget {
  const ListTeacherPage({Key? key}) : super(key: key);

  @override
  State<ListTeacherPage> createState() => _ListTeacherPageState();
}

class _ListTeacherPageState extends State<ListTeacherPage> {
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
  var favoriteTecher = [];
  List<Teacher> teacherList = [];

  @override
  void initState() {
    super.initState();
    TeacherController.getListTeacher().then(
      (value) {
        setState(() {
          teacherList = value;
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasLesson = true;

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
                        Text(
                          'You have no upcoming lesson.',
                          style: LettutorFontStyles.tagSelectedText.copyWith(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        hasLesson
                            ? Row(
                                children: [
                                  Text(
                                    'Sun, 23 Oct 22 00:00 - 00:25',
                                    maxLines: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      PushTo(
                                          context: context,
                                          destination: VideoConferencePage());
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
                            : Text(
                                'Total lesson time is 3 hours 20 minutes',
                                style:
                                    LettutorFontStyles.tagSelectedText.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )
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
                  Container(
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
                                  onFavoriteTap: () {
                                    setState(() {
                                      favoriteTecher[index] =
                                          !favoriteTecher[index];
                                    });
                                  },
                                )),
                        TeacherPagination(),
                      ],
                    ),
                  )
                ],
              ));
  }
}
