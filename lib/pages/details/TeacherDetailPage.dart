import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/pages/account/SettingPage.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/details/BookingTable.dart';
import 'package:let_tutor/utils/components/details/SkillTag.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(
        'https://api.app.lettutor.com/video/4d54d3d7-d2a9-42e5-97a2-5ed38af5789avideo1627913015871.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
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
              icon: Icon(
                Icons.flag_circle,
                color: Colors.black,
              ),
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
          IconButton(
            onPressed: () {
              PushTo(context: context, destination: SettingPage());
            },
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: ListView(
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
                            style: LettutorFontStyles.descriptionText.copyWith(
                                color: const Color.fromRGBO(11, 34, 57, 1.0)),
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
            style: LettutorFontStyles.descriptionText,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite,
                    ),
                    Text('Favorite')
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Icon(
                      Icons.report,
                    ),
                    Text('Report')
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Icon(
                      Icons.star,
                    ),
                    Text('Reviews')
                  ],
                ),
              )
            ],
          ),
          Container(
            height: 300,
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          Text('Languages'),
          Wrap(
            children: [
              SkillTag(
                skill: 'English',
                selected: true,
              )
            ],
          ),
          Text('Specialties'),
          Wrap(
            children: [
              ...widget.teacher.tags.map((e) => SkillTag(
                    skill: e,
                    selected: true,
                  ))
            ],
          ),
          Text('Suggested courses'),
          Row(
            children: [
              Text('Basic Conversation Topics:'),
              TextButton(onPressed: () {}, child: Text('link'))
            ],
          ),
          Row(
            children: [
              Text('Life in the Internet Age:'),
              TextButton(onPressed: () {}, child: Text('link'))
            ],
          ),
          Text('Interests'),
          Text(
            ' I loved the weather, the scenery and the laid-back lifestyle of the locals.',
            maxLines: 4,
          ),
          Text('Teaching experience'),
          Text(
            'I have more than 10 years of teaching english experience',
            maxLines: 4,
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
    );
  }
}
