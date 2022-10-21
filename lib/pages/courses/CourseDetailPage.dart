import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/models/Course.dart';
import 'package:let_tutor/utils/styles/styles.dart';

class CourseDetail extends StatelessWidget {
  final Course course;
  const CourseDetail({required this.course, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: LoginAppBar(context),
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
                  course.imgURL,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Text(
                course.courseName,
                style: LettutorFontStyles.searchTitle,
              ),
              Text(
                course.description,
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
            'Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor.',
            maxLines: 10,
          ),
          RowIconText(
              'assets/icons/question-circle.svg', "What will you able to do"),
          Text(
            'You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends.',
            maxLines: 10,
          ),
          Header('Experience Level'),
          RowIconText('assets/icons/usergroup-add.svg', course.level),
          Header('Course Length'),
          RowIconText('assets/icons/book.svg', "${course.numLessons} topics"),
          Header('List Topic'),
          ...List.generate(
            course.numLessons,
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
