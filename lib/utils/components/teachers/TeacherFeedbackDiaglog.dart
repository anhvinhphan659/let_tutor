import 'package:flutter/material.dart';
import 'package:let_tutor/handler/tutor/teacher_controller.dart';
import 'package:let_tutor/models/teacher/feedback.dart';
import 'package:let_tutor/models/teacher/teacher.dart';
import 'package:let_tutor/utils/components/teachers/StateAvatar.dart';
import 'package:let_tutor/utils/styles/styles.dart';
import 'package:let_tutor/utils/util_function.dart';
import 'package:number_paginator/number_paginator.dart';

class TeacherFeedbackDialog extends StatefulWidget {
  final Teacher teacher;
  const TeacherFeedbackDialog({required this.teacher, Key? key})
      : super(key: key);

  @override
  State<TeacherFeedbackDialog> createState() => _TeacherFeedbackDialogState();
}

class _TeacherFeedbackDialogState extends State<TeacherFeedbackDialog> {
  int pageCount = 1;
  int _currentPage = 1;
  static const int PER_PAGE = 12;
  bool isLoading = true;
  List<FeedbackTeacher> feedbacks = <FeedbackTeacher>[];
  late String teacherID;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    teacherID = widget.teacher.userId ?? "";
    updateListFeedback();
  }

  void updateListFeedback() {
    setState(() {
      isLoading = true;
    });
    TeacherController.getListFeedbackByTeacher(
      teacherID,
      page: _currentPage,
      perPage: PER_PAGE,
    ).then((value) {
      int count = value['count'];
      List<FeedbackTeacher> feedbackList =
          value['listFeedback'] ?? <FeedbackTeacher>[];
      setState(() {
        pageCount = (count / PER_PAGE).ceil();
        feedbacks.clear();
        feedbacks = feedbackList;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_currentPage);
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Others review"),
              CloseButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
          Divider(),
          isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6 - 80,
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...feedbacks.map(
                            (e) => FeedbackRow(e),
                          ),
                          pageCount > 0
                              ? NumberPaginator(
                                  numberPages: pageCount,
                                  initialPage: (_currentPage - 1),
                                  onPageChange: (pageIndex) {
                                    setState(() {
                                      _currentPage = pageIndex + 1;
                                      isLoading = true;
                                    });
                                    print("Page index: $pageIndex");
                                    updateListFeedback();
                                  },
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      height: 100,
                                    ),
                                    Text("No reviews for this tutor"),
                                    SizedBox(
                                      height: 100,
                                    ),
                                  ],
                                ),
                        ]),
                  ),
                )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget FeedbackRow(FeedbackTeacher f) {
    DateTime d = DateTime.tryParse(f.updatedAt!) ?? DateTime.now();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: StateAvatar(
              backgroundRadius: 16,
              child: CircleAvatar(
                child: Image.network(f.firstInfo!.avatar!),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Text(
                    f.firstInfo!.name!,
                    style: LettutorFontStyles.commentText,
                  ),
                  Text(
                    " ${getDifferenceTime(d)} ago",
                    style: LettutorFontStyles.commentText
                        .copyWith(color: Colors.grey.shade300),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    ...List.generate(
                      (f.rating ?? 0.0).floor(),
                      (_) => const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 12,
                      ),
                    ),
                    ...List.generate(
                      (5 - (f.rating ?? 0.0).floor()),
                      (_) => const Icon(
                        Icons.star,
                        color: Colors.grey,
                        size: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Text(
                  f.content!,
                  maxLines: 3,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
