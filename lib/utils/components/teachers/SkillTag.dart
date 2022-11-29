import 'package:flutter/material.dart';
import 'package:let_tutor/utils/styles/styles.dart';

var skillTags = {
  "english-for-studing-abroad": "For Studing Abroad",
  "english-for-kids": "English for Kid",
  "english-for-traveling": "English for Traveling",
  "conversational-english": "Conversational English",
  "business-english": "Business English",
  "starters": "STARTERS",
  "movers": "MOVERS",
  "flyers": "FLYERS",
  "ket": "KET",
  "pet": "PET",
  "ielts": "IELTS",
  "toefl": "TOEFL",
  "toeic": "TOEIC",
};

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
