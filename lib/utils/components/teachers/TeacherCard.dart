import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/pages/teachers/TeacherDetailPage.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/SkillTag.dart';
import 'package:let_tutor/utils/components/teachers/StateAvatar.dart';
import 'package:let_tutor/utils/models/Teacher.dart';
import 'package:let_tutor/utils/styles/styles.dart';

class TeacherCard extends StatelessWidget {
  final Teacher teacher;
  bool isActive;

  bool isFavorite;
  Function? onFavoriteTap;
  TeacherCard(
      {required this.teacher,
      this.isActive = false,
      this.isFavorite = false,
      this.onFavoriteTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.16), blurRadius: 5.0)
          ]),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  PushTo(
                      context: context,
                      destination: TeacherDetailPage(teacher: teacher));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        StateAvatar(
                          foregroundRadius: 5,
                          backgroundRadius: 30,
                          dx: 46,
                          child: Image.asset(
                            'assets/images/teacher1.png',
                            fit: BoxFit.fitHeight,
                          ),
                          displayTop: true,
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
                            teacher.name,
                            style: LettutorFontStyles.teacherNameText,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 18,
                                width: 24,
                                child: SvgPicture.network(
                                  teacher.national_img,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                teacher.nationality,
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
                                  teacher.star,
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
              IconButton(
                onPressed: () {
                  onFavoriteTap!();
                },
                icon: isFavorite
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite_border,
                        color: LettutorColors.blueColor,
                      ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: Wrap(
            children: [
              ...teacher.tags.map((e) => SkillTag(
                    skill: e,
                    selected: true,
                  ))
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: Padding(
            padding: EdgeInsets.zero,
            child: Text(
              teacher.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              decoration: BoxDecoration(
                  border: Border.all(color: LettutorColors.lightBlueColor),
                  borderRadius: BorderRadius.circular(15.0)),
              child: GestureDetector(
                onTap: () {
                  PushTo(
                      context: context,
                      destination: TeacherDetailPage(teacher: teacher));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: LettutorColors.lightBlueColor,
                    ),
                    Text(
                      'Book',
                      style: LettutorFontStyles.descriptionText.copyWith(
                        color: LettutorColors.lightBlueColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ]),
    );
  }
}
