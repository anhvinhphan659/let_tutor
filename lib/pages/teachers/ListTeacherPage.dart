import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/getwidget.dart';
import 'package:let_tutor/pages/conference/VideoConference.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/SkillTag.dart';
import 'package:let_tutor/utils/components/teachers/TeacherCard.dart';
import 'package:let_tutor/utils/models/Teacher.dart';
import 'package:let_tutor/utils/styles/styles.dart';

import 'TeacherPagination.dart';

class ListTeacherPage extends StatefulWidget {
  const ListTeacherPage({Key? key}) : super(key: key);

  @override
  State<ListTeacherPage> createState() => _ListTeacherPageState();
}

class _ListTeacherPageState extends State<ListTeacherPage> {
  var skills = [
    "Tất cả",
    "Tiếng Anh cho trẻ em",
    "Tiếng Anh cho công việc",
    "Giao tiếp",
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

  @override
  Widget build(BuildContext context) {
    bool hasLesson = true;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Container(
            height: 39,
            child: SvgPicture.asset(
              'assets/images/lettutor_logo.svg',
              fit: BoxFit.fitWidth,
            ),
          ),
          leadingWidth: 300,
          actions: [
            PopupMenuButton<int>(
                offset: Offset(0, 60),
                icon: Icon(Icons.flag_circle),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      child: Text('Option 1'),
                      value: 1,
                    ),
                    PopupMenuItem<int>(
                      child: Text('Option 2'),
                      value: 2,
                    ),
                    PopupMenuItem<int>(
                      child: Text('Option 3'),
                      value: 3,
                    ),
                  ];
                }),
          ],
        ),
        body: ListView(
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
                                      borderRadius: BorderRadius.circular(40)),
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
                          style: LettutorFontStyles.tagSelectedText.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        )
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Tìm kiếm gia sư",
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
                            hintText: "Nhập tên gia sư...",
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
                          child:
                              // DropdownButton<String>(
                              //   items: [
                              //     DropdownMenuItem<String>(
                              //       child: Text('Gia sư nước ngoài'),
                              //       value: "Gia sư nước ngoài",
                              //     ),
                              //     DropdownMenuItem<String>(
                              //       child: Text('Gia sư Việt Nam'),
                              //       value: "Gia sư Việt Nam",
                              //     ),
                              //     DropdownMenuItem<String>(
                              //       child: Text('Gia sư Tiếng Anh Bản Ngữ'),
                              //       value: "Gia sư Tiếng Anh Bản Ngữ",
                              //     ),
                              //   ],
                              //   value: "",
                              //   onChanged: (value) {},
                              //   hint: Text('Chọn quôc tịch gia sư'),
                              // ),
                              GFMultiSelect(
                                  // dropdownTitleTileBorder: Border.all(
                                  //     color:
                                  //         const Color.fromRGBO(217, 217, 217, 1.0),
                                  //     width: 1),
                                  // dropdownTitleTileBorderRadius:
                                  //     BorderRadius.circular(50),
                                  size: 15,
                                  dropdownTitleTilePadding: EdgeInsets.zero,
                                  dropdownTitleTileText:
                                      "Chọn quôc tịch gia sư",
                                  dropdownUnderlineBorder: BorderSide(width: 0),
                                  dropdownTitleTileMargin:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  hideDropdownUnderline: true,
                                  dropdownTitleTileHintTextStyle:
                                      LettutorFontStyles.hintText,
                                  dropdownTitleTileTextStyle:
                                      LettutorFontStyles.hintText,
                                  items: [
                                    "Gia sư nước ngoài",
                                    "Gia sư Việt Nam",
                                    "Gia sư Tiếng Anh Bản Ngữ",
                                  ],
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 4.0),
                                  margin: EdgeInsets.zero,
                                  onSelect: ((value) => print(value)))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Chọn thời gian dạy kèm có lịch trống:',
                      style:
                          LettutorFontStyles.searchTitle.copyWith(fontSize: 14),
                    ),
                  ),
                  Wrap(
                    children: [
                      Container(
                        width: 125,
                        child: TextField(
                            decoration: InputDecoration(
                          hintText: "Chọn một ngày",
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
                          hintText: "Giờ bắt đầu ...",
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
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: LettutorColors.lightBlueColor),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedSkill = 0;
                        });
                      },
                      child: Text(
                        'Đặt lại bộ tìm kiếm',
                        style: LettutorFontStyles.descriptionText.copyWith(
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
                    'Gia sư được đề xuất',
                    style: LettutorFontStyles.searchTitle.copyWith(
                      fontSize: 25,
                    ),
                  ),
                  Text("List gia sư"),
                  ...sampleTeachers.map(
                    (e) => TeacherCard(teacher: e),
                  ),
                  TeacherPagination(),
                ],
              ),
            )
          ],
        ));
  }
}
