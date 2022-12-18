import 'package:flutter/material.dart';
import 'package:let_tutor/models/course/course.dart';
import 'package:let_tutor/pages/courses/CourseDetailPage.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/styles/styles.dart';
import 'package:let_tutor/utils/util_function.dart';

class CourseListTopicPage extends StatefulWidget {
  final Course course;
  final int selectedIndex = 0;
  const CourseListTopicPage({required this.course, Key? key}) : super(key: key);

  @override
  State<CourseListTopicPage> createState() => _CourseListTopicPageState();
}

class _CourseListTopicPageState extends State<CourseListTopicPage> {
  int selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Course course = widget.course;
    //TODO: display file
    displayURL(course.topics![selectedIndex].nameFile ?? "");
    return Scaffold(
      appBar: const LettutorAppBar(),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromRGBO(228, 228, 228, 1.0),
                    width: 1.0),
              ),
              child: Column(
                children: [
                  Image.network(
                    course.imageUrl ?? "",
                    fit: BoxFit.fitWidth,
                  ),
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(course.name ?? "", displayDivider: false),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 7.5),
                          child: Text(course.description ?? ""),
                        ),
                        Header('List Topic', displayDivider: false),
                        ...List.generate(
                          course.topics!.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 4.0),
                              decoration: BoxDecoration(
                                color: index == selectedIndex
                                    ? const Color.fromRGBO(0, 0, 0, 0.08)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Text(
                                          "${index + 1}.",
                                          style: LettutorFontStyles.h5Title
                                              .copyWith(fontSize: 14),
                                        ),
                                      ),
                                      Container(
                                        constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          course.topics![index].name ?? "",
                                          style: LettutorFontStyles.h5Title
                                              .copyWith(fontSize: 14),
                                          maxLines: 4,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
