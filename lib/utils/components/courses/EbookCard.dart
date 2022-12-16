import 'package:flutter/material.dart';

import 'package:let_tutor/pages/courses/CourseDetailPage.dart';
import 'package:let_tutor/utils/components/common.dart';

import 'package:let_tutor/utils/styles/styles.dart';

import '../../../models/course/e_book.dart';

class EBookCard extends StatelessWidget {
  final EBook ebook;
  const EBookCard({required this.ebook, Key? key}) : super(key: key);

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
    // int numberLesson = (ebook.topics ?? []).length;
    return GestureDetector(
      onTap: () {
        // PushTo(context: context, destination: CourseDetail(course: ebook));
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
        width: 290,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 210,
                  child: Image.network(
                    ebook.imageUrl ?? "",
                    fit: BoxFit.fitWidth,
                  ),
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
                          ebook.name ?? "",
                          style: LettutorFontStyles.courseTitle,
                        ),
                        Text(
                          ebook.description ?? "",
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
                child: Text(getLevel(int.parse(ebook.level ?? "1"))),
              ),
            ]),
      ),
    );
  }
}
