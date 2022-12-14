import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/models/schedule/booking_history.dart';
import 'package:let_tutor/utils/components/teachers/StateAvatar.dart';
import 'package:let_tutor/utils/models/Schedule.dart';
import 'package:let_tutor/utils/styles/styles.dart';
import 'package:let_tutor/utils/util_function.dart';

class HistoryScheduleCard extends StatefulWidget {
  final BookingSchedule schedule;
  const HistoryScheduleCard({required this.schedule, Key? key})
      : super(key: key);

  @override
  State<HistoryScheduleCard> createState() => _HistoryScheduleCardState();
}

class _HistoryScheduleCardState extends State<HistoryScheduleCard> {
  @override
  Widget build(BuildContext context) {
    var schedule = widget.schedule;
    var teacher = widget.schedule.scheduleDetailInfo!.scheduleInfo!.tutorInfo;
    var scheduleDetail = widget.schedule.scheduleDetailInfo!;
    var classReview = schedule.classReview;
    var feedBacks = schedule.feedbacks ?? <Feedbacks>[];
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
                "${getDifferenceTime(startTime)} ago",
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ignore: prefer_interpolation_to_compose_strings
                Text('Lesson Time: ' +
                    convertTimeStampToHour(
                        scheduleDetail.startPeriodTimestamp ?? 0) +
                    "-" +
                    convertTimeStampToHour(
                        scheduleDetail.endPeriodTimestamp ?? 0)),
                (schedule.showRecordUrl ?? false)
                    ? Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: 140),
                            child: ElevatedButton(
                                onPressed: () {
                                  print(
                                      "Record URL: ${schedule.recordUrl ?? ""}");
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Icon(
                                      Icons.smart_display_outlined,
                                      color: Colors.white,
                                    ),
                                    Text("Record")
                                  ],
                                )),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 1),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white,
            child: schedule.studentRequest != null
                ? Container(
                    constraints: BoxConstraints(maxHeight: 80),
                    child: ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      tilePadding: EdgeInsets.all(0),
                      childrenPadding: EdgeInsets.all(0),
                      title: Text("Request for lesson"),
                      textColor: Colors.black,
                      collapsedTextColor: Colors.black,
                      children: [Text(schedule.studentRequest!)],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text('No request for lesson'),
                      ],
                    ),
                  ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 1),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: Colors.white,
            child: classReview != null
                ? ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: const Text("Review from tutor"),
                    expandedAlignment: Alignment.centerLeft,
                    children: [
                      Text(scheduleDetail.getSessionInfo()),
                      Text(
                        classReview.getLessonStatus(),
                        maxLines: 9,
                      ),
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: const [
                        Text('Tutor haven\'t reviewed yet'),
                      ],
                    ),
                  ),
          ),
          feedBacks.length == 0
              ? Container(
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
                )
              : const SizedBox(),
          ...feedBacks.map((e) => FeedBackWidget(e)),
        ],
      ),
    );
  }

  Widget FeedBackWidget(Feedbacks feed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.only(left: 16),
      color: Colors.white,
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Rating: "),
              ...List.generate(
                feed.rating ?? 0,
                (index) => const Icon(
                  Icons.star_rounded,
                  color: Colors.yellow,
                ),
              ),
              ...List.generate(
                5 - (feed.rating ?? 0),
                (index) => Icon(
                  Icons.star_rounded,
                  color: Colors.grey.shade200,
                ),
              ),
            ],
          ),
          TextButton(onPressed: () {}, child: Text("Edit")),
          TextButton(onPressed: () {}, child: Text("Report")),
        ],
      ),
    );
  }
}
