import 'package:expandable_text/expandable_text.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/models/teacher.dart';
import 'package:let_tutor/pages/account/SettingPage.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/BookingTable.dart';
import 'package:let_tutor/utils/components/teachers/SkillTag.dart';

import 'package:let_tutor/utils/styles/styles.dart';
import 'package:let_tutor/utils/util_function.dart';
import 'package:video_player/video_player.dart';

class TeacherDetailPage extends StatefulWidget {
  final Teacher teacher;

  TeacherDetailPage({required this.teacher, Key? key}) : super(key: key);

  @override
  State<TeacherDetailPage> createState() => _TeacherDetailPageState();
}

class _TeacherDetailPageState extends State<TeacherDetailPage> {
  late VideoPlayerController _controller;
  late FlickManager flickManager;
  late Teacher teacher;

  bool isFavorite = false;
  bool isLoading = true;

  @override
  void initState() {
    teacher = widget.teacher;

    _controller = VideoPlayerController.network(teacher.video ?? "");
    _controller.initialize().then((value) {
      setState(() {
        flickManager = FlickManager(videoPlayerController: _controller);
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  var initialDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LettutorAppBar(),
      body: Container(
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
                      ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(35),
                          child: Image.asset(
                            'assets/images/teacher1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
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
                              child: SvgPicture.network(
                                'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/${(teacher.country ?? "VN").toLowerCase()}.svg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              teacher.country ?? "",
                              style: LettutorFontStyles.descriptionText
                                  .copyWith(
                                      color: const Color.fromRGBO(
                                          11, 34, 57, 1.0)),
                            )
                          ],
                        ),
                        Row(
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
                  onTap: () {},
                  child: Column(
                    children: [
                      Icon(
                        Icons.report_rounded,
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
              child: _controller.value.isInitialized
                  ? FlickVideoPlayer(
                      flickManager: flickManager,
                      flickVideoWithControls: const FlickVideoWithControls(
                        videoFit: BoxFit.fitHeight,
                        controls: FlickPortraitControls(),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                      color: Colors.grey,
                    )),
            ),
            Text(
              'Languages',
              style: LettutorFontStyles.headerTeacherDetail,
            ),
            Wrap(
              children: [
                ...(teacher.languages ?? "").split(",").map((e) => SkillTag(
                      skill: getCountryNameFromCode(e) ?? "",
                      selected: true,
                    ))
              ],
            ),
            Text(
              'Specialties',
              style: LettutorFontStyles.headerTeacherDetail,
            ),
            Wrap(
              children: [
                ...(teacher.specialties ?? "").split(",").map((e) => SkillTag(
                      skill: skillTags[e] ?? "",
                      selected: true,
                    ))
              ],
            ),
            Text(
              'Suggested courses',
              style: LettutorFontStyles.headerTeacherDetail,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    'Basic Conversation Topics:',
                    style: LettutorFontStyles.h5Text,
                  ),
                  TextButton(onPressed: () {}, child: Text('link'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    'Life in the Internet Age:',
                    style: LettutorFontStyles.h5Text,
                  ),
                  TextButton(onPressed: () {}, child: Text('link'))
                ],
              ),
            ),
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
                      setState(() {
                        initialDate =
                            initialDate.subtract(const Duration(days: 7));
                        print('New inital: ' + initialDate.toString());
                      });
                    },
                    child: Text('<')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        initialDate = initialDate.add(const Duration(days: 7));
                        print('New inital: ' + initialDate.toString());
                      });
                    },
                    child: Text('>')),
                Text(getDisplayTitle(initialDate))
              ],
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                    width: 500,
                    child: BookingTable(
                      initialDate: initialDate,
                    )))
          ],
        ),
      ),
    );
  }
}
