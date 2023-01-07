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
import 'package:number_paginator/number_paginator.dart';

class ListCoursePage extends StatefulWidget {
  const ListCoursePage({Key? key}) : super(key: key);

  @override
  State<ListCoursePage> createState() => _ListCoursePageState();
}

class _ListCoursePageState extends State<ListCoursePage> {
  final TextEditingController courseSearchController = TextEditingController();
  //--handle for search data
  String q = "";
  List<int> level = [];
  List<String> categoryId = [];
  String orderBy = "DESC";
  //end --handle for search data
  //--handle for pagination
  int pageCount = 1;
  int _currentPage = 1;
  //end --handle for pagination
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState

    initData();
    super.initState();
  }

  Future<void> initData() async {
    await updateDisplayData();
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
    ...UtilStorage.contentCategories,
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
  Future updateDisplayData() async {
    setState(() {
      isLoading = true;
    });

    if (_selectedTab.contains("Course")) {
      print("Course update");
      print(orderBy);
      List<Course> courses = await CourseController.getListCourse(
        level: level,
        q: q,
        orderBy: orderBy,
        categoryId: categoryId,
      );
      setState(() {
        tabOptions["Course"] = CourseController.getCourseCardsFromList(courses);
      });
    } else if (_selectedTab.contains("Book")) {
      var result = await CourseController.getListEBook(
        page: _currentPage,
        perPage: 10,
        level: level,
        q: q,
        orderBy: orderBy,
        categoryId: categoryId,
      );
      int count = result['count'] ?? 0;
      pageCount = (count / 10).ceil();
      List<EBook> ebooks = result["e-books"] ?? <EBook>[];
      tabOptions["E-Book"] = CourseController.getEbookCardsFromList(ebooks);
    }
    setState(() {
      print("Call end update");
      isLoading = false;
    });
  }

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
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: TextField(
                            onSubmitted: (value) {
                              q = courseSearchController.text;
                              updateDisplayData();
                            },
                            controller: courseSearchController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                        ),
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
                    initialValue: level,
                    items: List.generate(levels.length,
                        (index) => MultiSelectItem(index, levels[index])),
                    onConfirm: (val) {
                      level.clear();
                      level = val;
                      print(level);
                      updateDisplayData();
                    },
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
                        .map((e) => MultiSelectItem(e.id, e.title ?? ""))
                        .toList(),
                    onConfirm: (val) {
                      print(val);
                      categoryId.clear();
                      for (var v in val) {
                        if (v != null) {
                          categoryId.add(v);
                        }
                      }
                      updateDisplayData();
                    },
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
                        if ((_sortOptionSelected ?? 0) == 0) {
                          orderBy = "DESC";
                        } else {
                          orderBy = "ASC";
                        }
                        updateDisplayData();
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
                    courseSearchController.clear();
                    //update query params
                    q = "";
                    orderBy = "DESC";

                    //update option
                    _sortOptionSelected = null;
                    _selectedTab = tabOptions.keys.toList()[index];
                  });
                  updateDisplayData();
                },
              ),
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : courseWidgets.isNotEmpty
                    ? Container(
                        child: Wrap(
                          children: [
                            ...courseWidgets,
                            _selectedTab.contains("Book")
                                ? NumberPaginator(
                                    numberPages: pageCount,
                                    initialPage: _currentPage - 1,
                                    onPageChange: (pageIndex) {
                                      setState(() {
                                        _currentPage = pageIndex + 1;
                                      });
                                      updateDisplayData();
                                    },
                                  )
                                : const SizedBox(),
                          ],
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
