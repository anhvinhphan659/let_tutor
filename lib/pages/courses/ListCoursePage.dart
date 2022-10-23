import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/courses/CourseCard.dart';
import 'package:let_tutor/utils/models/Course.dart';
import 'package:let_tutor/utils/styles/styles.dart';

class ListCoursePage extends StatefulWidget {
  const ListCoursePage({Key? key}) : super(key: key);

  @override
  State<ListCoursePage> createState() => _ListCoursePageState();
}

class _ListCoursePageState extends State<ListCoursePage> {
  var searchOptionsHeaders = [
    "Select level",
    "Select category",
    "Sort by level",
  ];
  var searchOptionWidgets = [
    [
      "Any Level",
      "Beginner",
      "Higher Beginner",
      "Pre-Intermediate",
      "Intermediate",
      "Upper-Intermediate",
      "Pre-Advanced",
      "Advanced",
    ],
    [
      "For Studing Abroad",
      "English for Kid",
      "English for Traveling",
      "Conversational English",
      "Business English",
      "STARTERS",
      "MOVERS",
      "FLYERS",
      "KET",
      "PET",
      "IELTS",
      "TOEFL",
      "TOEIC",
    ],
    [
      "Level decreasing",
      "Level increasing",
    ]
  ];
  var tabOptions = {
    "Course:": [
      Course(
          courseName: "Life in the Internet Age",
          description:
              "Let's discuss how technology is changing the way we live",
          level: "Intermediate",
          numLessons: 9,
          imgURL:
              'https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e.png'),
      Course(
          courseName: "Caring for Our Planet",
          description:
              "Let's discuss our relationship as humans with our planet, Earth",
          level: "Intermediate",
          numLessons: 7,
          imgURL:
              'https://camblycurriculumicons.s3.amazonaws.com/5e2b99f70f8f1e9f625e8317?h=d41d8cd98f00b204e9800998ecf8427e.png'),
      Course(
          courseName: "Healthy Mind, Healthy Body",
          description:
              "Let's discuss the many aspects of living a long, happy life",
          level: "Intermediate",
          numLessons: 6,
          imgURL:
              'https://camblycurriculumicons.s3.amazonaws.com/5e2b9a4c05342470fdddf8b8?h=d41d8cd98f00b204e9800998ecf8427e.png')
    ],
    "E-Book": [
      Course(
          courseName: "Let’s go begin",
          description:
              "For kids who start learning English the first time or speak a little English only (reading skills are limited).",
          level: "Beginner",
          imgURL:
              'https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afilewhat_a_world.jpeg'),
      Course(
          courseName: "Caring for Our Planet",
          description:
              "Let's discuss our relationship as humans with our planet, Earth",
          level: "Intermediate",
          imgURL:
              'https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afilelets_go.jpeg'),
    ],
    "Interactive E-book": [],
  };
  String _selectedTab = 'Course';
  @override
  Widget build(BuildContext context) {
    // var screenWidth = MediaQuery.of(context).size.width;
    List<Widget> courseWidgets = [];
    var selectTab = tabOptions[_selectedTab];
    if (selectTab != null) {
      courseWidgets = selectTab.map((e) => CourseCard(course: e)).toList();
    }
    // print(screenWidth);
    return Scaffold(
      appBar: LettutorAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(right: 25),
                  child: SvgPicture.asset(
                    "assets/images/course.svg",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discover Courses',
                      style: LettutorFontStyles.h2Title,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                            width: 100,
                            height: 50,
                            child: TextField(
                              decoration:
                                  InputDecoration(border: OutlineInputBorder()),
                            )),
                        IconButton(onPressed: () {}, icon: Icon(Icons.search))
                      ],
                    )
                  ],
                )
              ],
            ),
            Text(
              'LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields.',
              maxLines: 4,
              style: LettutorFontStyles.normalText,
            ),
            Wrap(
              children: [
                ...List.generate(
                    searchOptionWidgets.length,
                    (index) => Container(
                          // decoration: BoxDecoration(
                          //     border: Border.all(
                          //         width: 1.0,
                          //         color: LettutorColors.lightGrayColor)),
                          padding: EdgeInsets.all(10),
                          constraints: BoxConstraints(maxWidth: 175),
                          child: GFMultiSelect(
                            dropdownTitleTileBorder: Border.all(
                                width: 1.0,
                                color: LettutorColors.lightGrayColor),
                            dropdownTitleTilePadding: EdgeInsets.zero,
                            dropdownTitleTileMargin: EdgeInsets.zero,
                            items: searchOptionWidgets[index],
                            dropdownTitleTileHintText:
                                searchOptionsHeaders[index],
                            dropdownTitleTileText: "",
                            onSelect: (value) {},
                          ),
                        ))
              ],
            ),
            DefaultTabController(
              length: 3,
              child: TabBar(
                unselectedLabelColor: Colors.black,
                labelColor: LettutorColors.lightBlueColor,
                tabs: [
                  ...tabOptions.keys.map((e) => Text(e)),
                ],
                onTap: (index) {
                  setState(() {
                    _selectedTab = tabOptions.keys.toList()[index];
                  });
                },
              ),
            ),
            Container(
              child: Wrap(
                children: courseWidgets,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
