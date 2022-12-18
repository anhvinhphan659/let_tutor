import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/handler/course/course_controller.dart';
import 'package:let_tutor/models/course/course.dart';
import 'package:let_tutor/models/course/course_detail.dart';
import 'package:let_tutor/models/teacher/teacher.dart';
import 'package:let_tutor/models/teacher/teacher_detail.dart';
import 'package:let_tutor/pages/teachers/TeacherDetailPage.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/courses/CourseCard.dart';

import 'package:let_tutor/utils/styles/styles.dart';

class CourseDetail extends StatefulWidget {
  final Course course;

  const CourseDetail({required this.course, Key? key}) : super(key: key);

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  List<SuggestTeacher> suggestedTeachers = <SuggestTeacher>[];

  Future initData() async {
    await CourseController.getCourseDetailByID(widget.course.id ?? "")
        .then((value) {
      if (value != null) {
        setState(() {
          suggestedTeachers = value.suggestTeachers ?? <SuggestTeacher>[];
        });
      }
    });
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initData();
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: LettutorAppBar(),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: ListView(children: [
          // Container(
          //   margin: const EdgeInsets.all(8.0),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(12),
          //     border: Border.all(
          //         color: Color.fromRGBO(216, 216, 216, 1.0), width: 1.0),
          //     boxShadow: [
          //       BoxShadow(
          //           color: Color.fromRGBO(216, 216, 216, 1.0),
          //           offset: Offset(0, 4)),
          //     ],
          //   ),
          //   child:
          //       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //     SizedBox(
          //       height: 210,
          //       child: Image.network(
          //         course.imageUrl ?? "",
          //         fit: BoxFit.fitWidth,
          //       ),
          //     ),
          //     Text(
          //       course.name ?? "",
          //       style: LettutorFontStyles.searchTitle,
          //     ),
          //     Text(
          //       course.description ?? "",
          //       maxLines: 2,
          //       overflow: TextOverflow.ellipsis,
          //       style: LettutorFontStyles.descriptionText,
          //     ),
          //     Container(
          //       alignment: Alignment.center,
          //       child: ElevatedButton(
          //         child: Text('Discover'),
          //         onPressed: () {},
          //       ),
          //     ),
          //   ]),
          // ),
          CourseCard(
            course: widget.course,
            displayDiscover: true,
          ),
          Header('Overview'),
          RowIconText(
              'assets/icons/question-circle.svg', "Why take this course"),
          Padding(
            padding: const EdgeInsets.only(left: 35.0, bottom: 14.0),
            child: Text(
              widget.course.reason ?? "",
              maxLines: 10,
              style: LettutorFontStyles.contentText,
            ),
          ),
          RowIconText(
              'assets/icons/question-circle.svg', "What will you able to do"),
          Padding(
            padding: const EdgeInsets.only(left: 35.0, bottom: 14.0),
            child: Text(
              widget.course.purpose ?? "",
              maxLines: 10,
              style: LettutorFontStyles.contentText,
            ),
          ),
          Header('Experience Level'),
          RowIconText('assets/icons/usergroup-add.svg',
              CourseCard.getLevel(int.parse(widget.course.level ?? "0")),
              iconColor: Colors.blue),
          Header('Course Length'),
          RowIconText(
              'assets/icons/book.svg', "${widget.course.topics!.length} topics",
              iconColor: Colors.blue),
          Header('List Topic'),
          ...List.generate(
            widget.course.topics!.length,
            (index) => Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(
                    232,
                    232,
                    232,
                    0.106,
                  ),
                  borderRadius: BorderRadius.circular(6),
                  border:
                      Border.all(color: Color.fromRGBO(215, 215, 215, 0.44))),
              height: 138,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${index + 1}."),
                  Text(
                    widget.course.topics![index].name ?? "",
                    style: LettutorFontStyles.h5Title.copyWith(fontSize: 14),
                  )
                ],
              ),
            ),
          ),
          suggestedTeachers.isNotEmpty
              ? Header('Suggested Tutors')
              : const SizedBox(),

          ...List.generate(
            suggestedTeachers.length,
            (index) => Row(
              children: [
                Text(suggestedTeachers[index].name ?? ""),
                TextButton(
                    onPressed: () {
                      PushTo(
                          context: context,
                          destination: TeacherDetailPage(
                            teacher: convertTeacherFromSuggestedTeacher(
                              suggestedTeachers[index],
                            ),
                          ));
                    },
                    child: const Text('More info'))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

Widget Header(String title, {bool displayDivider = true}) {
  return Row(
    children: [
      Padding(
        padding: EdgeInsets.all(displayDivider ? 0.0 : 16.0),
        child: Text(
          title,
          style: LettutorFontStyles.searchTitle.copyWith(fontSize: 22),
        ),
      ),
      displayDivider
          ? Flexible(
              child: Container(
                height: 1.5,
                color: LettutorColors.lightGrayColor,
              ),
            )
          : const Spacer()
    ],
  );
}

Widget RowIconText(String asset_url, String content,
    {Color iconColor = Colors.red}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        height: 20,
        width: 20,
        child: SvgPicture.asset(
          asset_url,
          fit: BoxFit.fitHeight,
          color: iconColor,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 6.0),
        child: Text(
          content,
          style: LettutorFontStyles.h3Title.copyWith(fontSize: 16),
        ),
      ),
    ],
  );
}
