import 'package:flutter/material.dart';
import 'package:let_tutor/models/course/course.dart';
import 'package:let_tutor/pages/courses/CourseDetailPage.dart';
import 'package:let_tutor/utils/components/common.dart';

import 'package:let_tutor/utils/styles/styles.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({required this.course, Key? key}) : super(key: key);

  static String getLevel(int level) {
    String res = "Beginner";
    if (level >= 4 && level < 7) {
      res = "Intermediate";
    }
    if (level >= 7) {
      res = "Advanced";
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    int numberLesson = (course.topics ?? []).length;
    return GestureDetector(
      onTap: () {
        PushTo(context: context, destination: CourseDetail(course: course));
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: Color.fromRGBO(216, 216, 216, 1.0), width: 1.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(216, 216, 216, 1.0),
                offset: Offset(0, 4)),
          ],
        ),
        height: 375,
        width: 375,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 210,
                child: Image.network(
                  course.imageUrl ?? "",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.name ?? "",
                          style: LettutorFontStyles.courseTitle,
                        ),
                        Text(
                          course.description ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: LettutorFontStyles.courseContent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
                child: Text(
                    '${getLevel(int.parse(course.level ?? "0"))} ${numberLesson > 0 ? " • $numberLesson Lessons" : ""}'),
              ),
            ]),
      ),
    );
  }
}
