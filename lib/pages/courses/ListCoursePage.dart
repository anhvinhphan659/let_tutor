import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:let_tutor/handler/course/course_controller.dart';
import 'package:let_tutor/models/course/course.dart';
import 'package:let_tutor/models/course/e_book.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/courses/CourseCard.dart';

import 'package:let_tutor/utils/styles/styles.dart';

class ListCoursePage extends StatefulWidget {
  const ListCoursePage({Key? key}) : super(key: key);

  @override
  State<ListCoursePage> createState() => _ListCoursePageState();
}

class _ListCoursePageState extends State<ListCoursePage> {
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState

    initData();
    super.initState();
  }

  Future<void> initData() async {
    List<Course> courses = await CourseController.getListCourse();
    List<EBook> ebooks = await CourseController.getListEBook();
    setState(() {
      tabOptions["Course"] = CourseController.getCourseCardsFromList(courses);
      tabOptions["E-Book"] = CourseController.getEbookCardsFromList(ebooks);
      isLoading = false;
    });
  }

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
  Map<String, List<Widget>> tabOptions = {
    "Course": [],
    "E-Book": [],
    "Interactive E-book": [],
  };
  String _selectedTab = 'Course';
  @override
  Widget build(BuildContext context) {
    // var screenWidth = MediaQuery.of(context).size.width;
    List<Widget> courseWidgets = [];

    courseWidgets = tabOptions[_selectedTab] ?? [] as List<Widget>;

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
            courseWidgets.length > 0
                ? Container(
                    child: Wrap(
                      children: courseWidgets,
                    ),
                  )
                : Column(
                    children: [
                      SvgPicture.asset('assets/images/ant_empty_img.svg'),
                      Text('No data')
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
