// import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/models/schedule/booking_history.dart';
import 'package:let_tutor/models/schedule/schedule.dart';
import 'package:let_tutor/utils/components/teachers/StateAvatar.dart';

import 'package:let_tutor/utils/styles/styles.dart';
import 'package:let_tutor/utils/util_function.dart';

class ScheduleCard extends StatefulWidget {
  final BookingSchedule schedule;
  const ScheduleCard({required this.schedule, Key? key}) : super(key: key);

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    var schedule = widget.schedule;
    var teacher = widget.schedule.scheduleDetailInfo!.scheduleInfo!.tutorInfo;
    var scheduleDetail = widget.schedule.scheduleDetailInfo!;
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(
        scheduleDetail.startPeriodTimestamp ?? 0);
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(12.0),
      color: const Color.fromRGBO(241, 241, 241, 1),
      child: Wrap(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 200),
            margin: const EdgeInsets.only(bottom: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                DateFormat("EEE, dd MMM yy").format(startTime),
                style: LettutorFontStyles.meeting_date,
              ),
              Text(
                "1 lesson",
                style: LettutorFontStyles.hintText,
              )
            ]),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 12),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Column(
                    children: [
                      StateAvatar(
                        foregroundRadius: 5,
                        backgroundRadius: 30,
                        dx: 46,
                        displayTop: teacher!.isActivated ?? false,
                        child: Image.network(
                          teacher!.avatar ?? "",
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
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
                            // child:
                            // SvgPicture.network(
                            //   teacher.national_img,
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          // Text(
                          //   teacher.nationality,
                          //   style: LettutorFontStyles.descriptionText.copyWith(
                          //       color: const Color.fromRGBO(11, 34, 57, 1.0)),
                          // )
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
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(convertTimeStampToHour(
                          scheduleDetail.startPeriodTimestamp ?? 0) +
                      "-" +
                      convertTimeStampToHour(
                          scheduleDetail.endPeriodTimestamp ?? 0)),
                  ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [Icon(Icons.cancel), Text('Cancel')],
                      ))
                ],
              ),
              ExpansionTile(
                title: Text('Request for lesson'),
                children: [
                  Text(
                    'Currently there are no requests for this class. Please write down any requests for the teacher.',
                    maxLines: 10,
                  )
                ],
              )
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Go to meeting'),
              )
            ],
          )
        ],
      ),
    );
  }
}
