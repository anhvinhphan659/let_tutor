import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/models/teacher/teacher.dart';
import 'package:let_tutor/pages/teachers/TeacherDetailPage.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/SkillTag.dart';
import 'package:let_tutor/utils/components/teachers/StateAvatar.dart';
import 'package:let_tutor/utils/data/country.dart';

import 'package:let_tutor/utils/styles/styles.dart';
import 'package:let_tutor/utils/util_function.dart';

class TeacherCard extends StatelessWidget {
  final Teacher teacher;

  final Function? onFavoriteTap;
  const TeacherCard({required this.teacher, this.onFavoriteTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget avatarWidget = DefaultAvatar(teacherName: teacher.name ?? "");
    if (teacher.avatar != null) {
      if (!teacher.avatar!.contains("avatar-default")) {
        avatarWidget = Image.network(
          teacher.avatar!,
          fit: BoxFit.fitHeight,
        );
      }
    }

    Country? country = getCountryByCodeName(teacher.country ?? "");
    String countryName = "";
    if (country != null) {
      countryName = country.name ?? "";
    }

    bool hasReview = (teacher.feedbacks ?? []).length > 0;
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
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
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
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .55),
                  child: Wrap(
                    children: [
                      Column(
                        children: [
                          StateAvatar(
                            foregroundRadius: 5,
                            backgroundRadius: 30,
                            dx: 46,
                            displayTop: teacher.isActivated ?? false,
                            child: avatarWidget,
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
                                  margin: const EdgeInsets.only(right: 4.0),
                                  child: SvgPicture.network(
                                    'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/${(teacher.country ?? "").toLowerCase()}.svg',
                                    fit: BoxFit.cover,
                                    placeholderBuilder: (context) => Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black
                                                  .withOpacity(0.85),
                                              width: 1)),
                                      height: 4,
                                      width: 3,
                                      child: const Icon(
                                        Icons.broken_image,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  countryName,
                                  style: LettutorFontStyles.descriptionText
                                      .copyWith(
                                          color: const Color.fromRGBO(
                                              11, 34, 57, 1.0)),
                                )
                              ],
                            ),
                            hasReview
                                ? Row(
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
                                : Text(
                                    "No reviews yet",
                                    style: LettutorFontStyles.reviewText,
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  onFavoriteTap!();
                },
                icon: teacher.isFavoriteTutor != null
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
        ClipRect(
          child: SizedBox(
            height: 70,
            child: Wrap(
              children: [
                ...(teacher.specialties ?? "").split(",").map((e) => SkillTag(
                      skill: skillTags[e] ?? "",
                      selected: true,
                    ))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: Padding(
            padding: EdgeInsets.zero,
            child: Text(
              teacher.bio ?? "",
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

Widget DefaultAvatar({String teacherName = "", int size = 20}) {
  var names = teacherName.split(" ");
  while (names.length < 2) {
    names.add(" ");
  }
  String defaultString = names[0].toUpperCase()[0] + names[1].toUpperCase()[0];
  return Container(
    height: 60,
    width: 60,
    color: Colors.blue,
    child: Center(
      child: Text(
        defaultString,
        style: LettutorFontStyles.defaultAvatarText,
      ),
    ),
  );
}
