import 'package:expandable_text/expandable_text.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/handler/schedule/schedule_controller.dart';
import 'package:let_tutor/handler/tutor/teacher_controller.dart';
import 'package:let_tutor/models/schedule/teacher_schedule.dart';
import 'package:let_tutor/models/teacher/teacher.dart';
import 'package:let_tutor/models/teacher/teacher_detail.dart';
import 'package:let_tutor/pages/account/SettingPage.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/BookingTable.dart';
import 'package:let_tutor/utils/components/teachers/SkillTag.dart';
import 'package:let_tutor/utils/components/teachers/StateAvatar.dart';
import 'package:let_tutor/utils/components/teachers/TeacherCard.dart';
import 'package:let_tutor/utils/data/country.dart';

import 'package:let_tutor/utils/styles/styles.dart';
import 'package:let_tutor/utils/util_function.dart';
import 'package:video_player/video_player.dart';

class TeacherDetailPage extends StatefulWidget {
  final Teacher teacher;

  const TeacherDetailPage({required this.teacher, Key? key}) : super(key: key);

  @override
  State<TeacherDetailPage> createState() => _TeacherDetailPageState();
}

class _TeacherDetailPageState extends State<TeacherDetailPage> {
  late VideoPlayerController _controller;
  late FlickManager flickManager;
  late Teacher teacher;
  late TeacherDetail teacherDetail;

  List<TeacherSchedule> bookingSchedule = <TeacherSchedule>[];

  bool isFavorite = false;
  bool isLoading = true;

  bool videoLoading = true;
  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    teacher = widget.teacher;
    print("Teacher video: ${teacher.video ?? ""}");

    _controller = VideoPlayerController.network(teacher.video ?? "");

    TeacherController.getTeacherDetail(teacher.userId!).then((value) async {
      setState(() {
        teacherDetail = value;
        isFavorite = teacherDetail.isFavorite ?? false;
        isLoading = false;
      });
    });

    _controller.initialize().then((value) {
      flickManager = FlickManager(videoPlayerController: _controller);
      setState(() {
        videoLoading = false;
      });
    });
    getListScheduleInWeek();

    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();

    super.dispose();
  }

  void getListScheduleInWeek() {
    print("call schefule controller");

    ScheduleController.getScheduleByTutor(teacher.userId!,
            startTime: initialDate)
        .then((value) {
      if (value.isNotEmpty) {
        bookingSchedule.clear();
        setState(() {
          bookingSchedule = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Country? country = getCountryByCodeName(teacher.country ?? "");
    String countryName = "";
    if (country != null) {
      countryName = country.name ?? "";
    }
    Widget avatarWidget = DefaultAvatar(teacherName: teacher.name ?? "");
    if (teacher.avatar != null) {
      if (!teacher.avatar!.contains("avatar-default")) {
        avatarWidget = Image.network(
          teacher.avatar!,
          fit: BoxFit.fitHeight,
        );
      }
    }

    return Scaffold(
      appBar: LettutorAppBar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 35),
              child: ListView(
                children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            StateAvatar(
                              foregroundRadius: 5,
                              backgroundRadius: 30,
                              dx: 46,
                              displayTop: teacher.isActivated ?? false,
                              child: avatarWidget,
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                teacher.name ?? "",
                                style: LettutorFontStyles.teacherNameText,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 18,
                                    width: 24,
                                    margin: const EdgeInsets.only(right: 4.0),
                                    child: SvgPicture.network(
                                      'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/${(teacher.country ?? "").toLowerCase()}.svg',
                                      fit: BoxFit.cover,
                                      placeholderBuilder: (context) =>
                                          Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.85),
                                                width: 1)),
                                        height: 4,
                                        width: 3,
                                        child: const Icon(
                                          Icons.broken_image,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    countryName,
                                    style: LettutorFontStyles.descriptionText
                                        .copyWith(
                                            color: const Color.fromRGBO(
                                                11, 34, 57, 1.0)),
                                  )
                                ],
                              ),
                              (teacherDetail.totalFeedback ?? 0) == 0
                                  ? Text(
                                      "No reviews yet",
                                      style: LettutorFontStyles.reviewText,
                                    )
                                  : Row(
                                      children: [
                                        ...List.generate(
                                          (teacher.rating ?? 0.0).floor(),
                                          (_) => const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 12,
                                          ),
                                        ),
                                        ...List.generate(
                                          (5 - (teacher.rating ?? 0.0).floor()),
                                          (_) => const Icon(
                                            Icons.star,
                                            color: Colors.grey,
                                            size: 12,
                                          ),
                                        ),
                                      ],
                                    )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  ExpandableText(
                    widget.teacher.bio ?? "",
                    expandText: 'More',
                    style: LettutorFontStyles.descriptionText
                        .copyWith(color: Color.fromRGBO(120, 120, 120, 1.0)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          TeacherController.addFavoriteTeacher(
                              teacher.userId ?? "");
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Column(
                          children: [
                            isFavorite
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: LettutorColors.blueColor,
                                  ),
                            Text(
                              'Favorite',
                              style: LettutorFontStyles.normalText.copyWith(
                                  color: isFavorite
                                      ? Colors.red
                                      : LettutorColors.blueColor),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          List<bool> options = [false, false, false];
                          List<String> textOptions = [
                            "This tutor is annoying me",
                            "This profile is pretending be someone or is fake",
                            "Inappropriate profile photo",
                          ];
                          bool canSubmit = false;
                          TextEditingController reportTextController =
                              TextEditingController();
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (_) =>
                                  StatefulBuilder(builder: (context, update) {
                                    return Container(
                                      height: 400,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24.0),
                                              child: Text(
                                                "Report ${teacher.name ?? ""}",
                                                style: LettutorFontStyles
                                                    .h3Title
                                                    .copyWith(fontSize: 18),
                                              ),
                                            ),
                                            Divider(),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24,
                                                      vertical: 13),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Wrap(
                                                    children: const [
                                                      Icon(
                                                        Icons.report,
                                                        color: Colors.blue,
                                                      ),
                                                      Text(
                                                          "Help us understand what's happening"),
                                                    ],
                                                  ),
                                                  ...List.generate(
                                                    options.length,
                                                    (index) => Row(
                                                      children: [
                                                        Checkbox(
                                                            value:
                                                                options[index],
                                                            onChanged: (value) {
                                                              update(() {
                                                                options[index] =
                                                                    value!;
                                                                for (var item
                                                                    in options) {
                                                                  if (item) {
                                                                    canSubmit =
                                                                        item;
                                                                    break;
                                                                  }
                                                                }

                                                                if (value) {
                                                                  reportTextController
                                                                          .text +=
                                                                      '${textOptions[index]}\n';
                                                                }
                                                              });
                                                            }),
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .7,
                                                            child: Text(
                                                                textOptions[
                                                                    index]))
                                                      ],
                                                    ),
                                                  ),
                                                  TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    controller:
                                                        reportTextController,
                                                    maxLines: 1,
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Cancel"),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          TeacherController
                                                              .reportTeacher(
                                                                  teacher.userId ??
                                                                      "",
                                                                  content:
                                                                      reportTextController
                                                                          .text);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Submit"),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ]),
                                    );
                                  }));
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.report_outlined,
                              color: LettutorColors.blueColor,
                            ),
                            Text(
                              'Report',
                              style: LettutorFontStyles.normalText
                                  .copyWith(color: LettutorColors.blueColor),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(
                              Icons.star_outline,
                              color: LettutorColors.blueColor,
                            ),
                            Text(
                              'Reviews',
                              style: LettutorFontStyles.normalText
                                  .copyWith(color: LettutorColors.blueColor),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 300,
                    child: videoLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.grey,
                          ))
                        : FlickVideoPlayer(
                            flickManager: flickManager,
                            flickVideoWithControls:
                                const FlickVideoWithControls(
                              videoFit: BoxFit.fitHeight,
                              controls: FlickPortraitControls(),
                            ),
                          ),
                  ),
                  Text(
                    'Languages',
                    style: LettutorFontStyles.headerTeacherDetail,
                  ),
                  Wrap(
                    children: [
                      ...(teacherDetail.languages ?? "").split(",").map((e) {
                        String language = getLanguageName(e);

                        return SkillTag(
                          skill: language,
                          selected: true,
                        );
                      }),
                    ],
                  ),
                  Text(
                    'Specialties',
                    style: LettutorFontStyles.headerTeacherDetail,
                  ),
                  Wrap(
                    children: [
                      ...(teacher.specialties ?? "")
                          .split(",")
                          .map((e) => SkillTag(
                                skill: skillTags[e] ?? "",
                                selected: true,
                              ))
                    ],
                  ),
                  Text(
                    'Suggested courses',
                    style: LettutorFontStyles.headerTeacherDetail,
                  ),
                  ...teacherDetail.user!.courses!.map(
                    (course) => Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 8),
                      child: CourseSuggestion(course),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Basic Conversation Topics:',
                  //         style: LettutorFontStyles.h5Text,
                  //       ),
                  //       TextButton(onPressed: () {}, child: Text('link'))
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         'Life in the Internet Age:',
                  //         style: LettutorFontStyles.h5Text,
                  //       ),
                  //       TextButton(onPressed: () {}, child: Text('link'))
                  //     ],
                  //   ),
                  // ),

                  Text(
                    'Interests',
                    style: LettutorFontStyles.headerTeacherDetail,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7, left: 15.0),
                    child: Text(
                      teacher.interests ?? "",
                      maxLines: 4,
                      style: LettutorFontStyles.contentText,
                    ),
                  ),
                  Text(
                    'Teaching experience',
                    style: LettutorFontStyles.headerTeacherDetail,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7, left: 15.0),
                    child: Text(
                      teacher.experience ?? "",
                      style: LettutorFontStyles.contentText,
                      maxLines: 4,
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            initialDate = DateTime.now();
                            print('New inital: ' + initialDate.toString());
                          });
                        },
                        child: Text('Today'),
                      ),
                      TextButton(
                        onPressed: () {
                          var newInitalDate =
                              initialDate.subtract(const Duration(days: 7));
                          if (newInitalDate.isBefore(DateTime.now()) == false) {
                            setState(() {
                              initialDate = newInitalDate;
                            });
                          }
                        },
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.black.withOpacity(0.85),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            initialDate =
                                initialDate.add(const Duration(days: 7));
                          });
                        },
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.black.withOpacity(0.85),
                        ),
                      ),
                      Text(getDisplayTitle(initialDate))
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: 500,
                      child: BookingTable(
                        initialDate: initialDate,
                        teacherSchedule: bookingSchedule,
                        callBack: () {
                          getListScheduleInWeek();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget CourseSuggestion(TeacherDetailCourse tdc) {
    return Row(
      children: [
        Text(
          tdc.name ?? "",
          style: LettutorFontStyles.h5Title,
        ),
        TextButton(
            onPressed: () {
              //TODO: send to detail course page
            },
            child: Text('link'))
      ],
    );
  }
}
