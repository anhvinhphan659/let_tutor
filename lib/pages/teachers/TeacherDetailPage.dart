import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/pages/account/SettingPage.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/BookingTable.dart';
import 'package:let_tutor/utils/components/teachers/SkillTag.dart';
import 'package:let_tutor/utils/models/Teacher.dart';
import 'package:let_tutor/utils/styles/styles.dart';
import 'package:video_player/video_player.dart';

class TeacherDetailPage extends StatefulWidget {
  final Teacher teacher;

  TeacherDetailPage({required this.teacher, Key? key}) : super(key: key);

  @override
  State<TeacherDetailPage> createState() => _TeacherDetailPageState();
}

class _TeacherDetailPageState extends State<TeacherDetailPage> {
  late VideoPlayerController _controller;

  bool isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(
        'https://api.app.lettutor.com/video/4d54d3d7-d2a9-42e5-97a2-5ed38af5789avideo1627913015871.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // mutes the video
      _controller.setVolume(0);
      // Plays the video once the widget is build and loaded.
      _controller.play();
    });
  }

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
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.teacher.name,
                          style: LettutorFontStyles.teacherNameText,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 18,
                              width: 24,
                              child: SvgPicture.network(
                                widget.teacher.national_img,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              widget.teacher.nationality,
                              style: LettutorFontStyles.contentText,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            ...List.generate(
                                widget.teacher.star,
                                (index) => const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 12,
                                    ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            ExpandableText(
              widget.teacher.description,
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
                        Icons.report,
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
                        Icons.star,
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
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            Text(
              'Languages',
              style: LettutorFontStyles.headerTeacherDetail,
            ),
            Wrap(
              children: [
                SkillTag(
                  skill: 'English',
                  selected: true,
                )
              ],
            ),
            Text(
              'Specialties',
              style: LettutorFontStyles.headerTeacherDetail,
            ),
            Wrap(
              children: [
                ...widget.teacher.tags.map((e) => SkillTag(
                      skill: e,
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
                ' I loved the weather, the scenery and the laid-back lifestyle of the locals.',
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
                'I have more than 10 years of teaching english experience',
                style: LettutorFontStyles.contentText,
                maxLines: 4,
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Today'),
                ),
                TextButton(onPressed: () {}, child: Text('<')),
                TextButton(onPressed: () {}, child: Text('>')),
                Text('Oct  -  Nov, 2022')
              ],
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(width: 500, child: BookingTable()))
          ],
        ),
      ),
    );
  }
}
