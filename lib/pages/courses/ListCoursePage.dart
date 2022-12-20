import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:let_tutor/handler/course/course_controller.dart';
import 'package:let_tutor/models/course/course.dart';
import 'package:let_tutor/models/course/e_book.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/courses/CourseCard.dart';
import 'package:let_tutor/utils/data/util_storage.dart';

import 'package:let_tutor/utils/styles/styles.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
  ];

  var levels = [
    "Any Level",
    "Beginner",
    "Higher Beginner",
    "Pre-Intermediate",
    "Intermediate",
    "Upper-Intermediate",
    "Pre-Advanced",
    "Advanced",
  ];

  var categories = [
    ...UtilStorage.learnTopics,
    ...UtilStorage.testPreparations,
  ];

  var sortSelections = {
    "Level Descreasing": 0,
    "Level Increasing": 1,
  };
  Map<String, List<Widget>> tabOptions = {
    "Course": [],
    "E-Book": [],
    "Interactive E-book": [],
  };
  String _selectedTab = 'Course';
  int? _sortOptionSelected;
  @override
  Widget build(BuildContext context) {
    // var screenWidth = MediaQuery.of(context).size.width;
    List<Widget> courseWidgets = [];

    courseWidgets = tabOptions[_selectedTab] ?? [] as List<Widget>;

    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const LettutorAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(maxWidth: screenWidth * .8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0, color: LettutorColors.lightGrayColor)),
                  child: MultiSelectDialogField(
                    buttonText: Text("Select level"),
                    title: Text("Select level"),
                    // title: Text("Select category"),

                    items: levels.map((e) => MultiSelectItem(e, e)).toList(),
                    onConfirm: (val) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(maxWidth: screenWidth * .8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0, color: LettutorColors.lightGrayColor)),
                  child: MultiSelectDialogField(
                    // title: Text("Select category"),
                    buttonText: Text("Select category"),
                    title: Text("Select category"),
                    items: categories
                        .map((e) => MultiSelectItem(e, e.name ?? ""))
                        .toList(),
                    onConfirm: (val) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(maxWidth: screenWidth * 0.8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0, color: LettutorColors.lightGrayColor)),
                  child: DropdownButton(
                    isExpanded: true,
                    underline: const SizedBox(),
                    hint: Text("Sort by level"),
                    items: sortSelections.keys
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e),
                            value: sortSelections[e],
                          ),
                        )
                        .toList(),
                    value: _sortOptionSelected,
                    onChanged: (value) {
                      setState(() {
                        _sortOptionSelected = value;
                      });
                    },
                  ),
                )
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
