import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/models/course.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/courses/CourseCard.dart';

import 'package:let_tutor/utils/styles/styles.dart';

class CourseDetail extends StatelessWidget {
  final Course course;
  const CourseDetail({required this.course, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: LettutorAppBar(),
      body: Container(
        color: Colors.white,
        child: ListView(children: [
          Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Color.fromRGBO(216, 216, 216, 1.0), width: 1.0),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(216, 216, 216, 1.0),
                    offset: Offset(0, 4)),
              ],
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 210,
                child: Image.network(
                  course.imageUrl ?? "",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Text(
                course.name ?? "",
                style: LettutorFontStyles.searchTitle,
              ),
              Text(
                course.description ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: LettutorFontStyles.descriptionText,
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: Text('Discover'),
                  onPressed: () {},
                ),
              ),
            ]),
          ),
          Header('Overview'),
          RowIconText(
              'assets/icons/question-circle.svg', "Why take this course"),
          Text(
            course.reason ?? "",
            maxLines: 10,
          ),
          RowIconText(
              'assets/icons/question-circle.svg', "What will you able to do"),
          Text(
            course.purpose ?? "",
            maxLines: 10,
          ),
          Header('Experience Level'),
          RowIconText('assets/icons/usergroup-add.svg',
              CourseCard.getLevel(int.parse(course.level ?? "0"))),
          Header('Course Length'),
          RowIconText(
              'assets/icons/book.svg', "${course.topics!.length} topics"),
          Header('List Topic'),
          ...List.generate(
            course.topics!.length,
            (index) => Container(
              margin: EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(
                    232,
                    232,
                    232,
                    0.106,
                  ),
                  borderRadius: BorderRadius.circular(6),
                  border:
                      Border.all(color: Color.fromRGBO(215, 215, 215, 0.44))),
              height: 138,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("${index + 1}."), Text("The Internet")],
              ),
            ),
          ),
          Header('Suggested Tutors'),
          Row(
            children: [
              Text('Keegan'),
              TextButton(onPressed: () {}, child: Text('More info'))
            ],
          )
        ]),
      ),
    );
  }

  Widget Header(String title) {
    return Row(
      children: [
        Text(
          title,
          style: LettutorFontStyles.searchTitle,
        ),
        Flexible(
          child: Container(
            height: 1.5,
            color: LettutorColors.lightGrayColor,
          ),
        )
      ],
    );
  }

  Widget RowIconText(String asset_url, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: SvgPicture.asset(
            asset_url,
            fit: BoxFit.fitHeight,
          ),
        ),
        Text(content),
      ],
    );
  }
}
