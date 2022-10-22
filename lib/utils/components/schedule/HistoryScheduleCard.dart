import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/utils/components/teachers/StateAvatar.dart';
import 'package:let_tutor/utils/models/Schedule.dart';
import 'package:let_tutor/utils/styles/styles.dart';

class HistoryScheduleCard extends StatefulWidget {
  final Schedule schedule;
  const HistoryScheduleCard({required this.schedule, Key? key})
      : super(key: key);

  @override
  State<HistoryScheduleCard> createState() => _HistoryScheduleCardState();
}

class _HistoryScheduleCardState extends State<HistoryScheduleCard> {
  @override
  Widget build(BuildContext context) {
    var teacher = widget.schedule.teacher;
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: const Color.fromRGBO(241, 241, 241, 1),
      child: Wrap(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 200),
            margin: const EdgeInsets.only(bottom: 12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(widget.schedule.date), Text('1 year ago')]),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            color: Colors.white,
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
                            style: LettutorFontStyles.descriptionText.copyWith(
                                color: const Color.fromRGBO(11, 34, 57, 1.0)),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 14,
                            height: 14,
                            child: SvgPicture.asset(
                              'assets/icons/message.svg',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Text('Direct Message')
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            color: Colors.white,
            child: Text(
                'Lesson Time: ${widget.schedule.startTime} - ${widget.schedule.endTime}'),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 1),
            color: Colors.white,
            child: Text('No request for lesson'),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 1),
            color: Colors.white,
            child: Text('Tutor haven\'t reviewed yet'),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 1),
            color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Add a rating'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Report'),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
