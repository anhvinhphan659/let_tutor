import 'package:flutter/material.dart';
import 'package:let_tutor/utils/styles/styles.dart';

var skillTags = [
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
];

class SkillTag extends StatelessWidget {
  String skill;
  bool selected;

  SkillTag({required this.skill, Key? key, this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: selected
              ? LettutorColors.selectedBackgroundColor
              : LettutorColors.unselectedBackgroundColor),
      child: Text(
        skill,
        style: selected
            ? LettutorFontStyles.tagSelectedText
            : LettutorFontStyles.tagUnSelectedText,
      ),
    );
  }
}
