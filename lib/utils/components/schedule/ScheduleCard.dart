// import 'package:expandable_text/expandable_text.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/handler/schedule/schedule_controller.dart';
import 'package:let_tutor/models/schedule/booking_history.dart';
import 'package:let_tutor/models/schedule/schedule.dart';
import 'package:let_tutor/pages/account/ProfilePage.dart';
import 'package:let_tutor/utils/components/teachers/StateAvatar.dart';

import 'package:let_tutor/utils/styles/styles.dart';
import 'package:let_tutor/utils/util_function.dart';

class ScheduleCard extends StatefulWidget {
  final BookingSchedule schedule;
  final Function? onCancelCallBack;
  const ScheduleCard({required this.schedule, this.onCancelCallBack, Key? key})
      : super(key: key);

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  bool isExpand = true;
  @override
  Widget build(BuildContext context) {
    var schedule = widget.schedule;
    var teacher = widget.schedule.scheduleDetailInfo!.scheduleInfo!.tutorInfo;
    var scheduleDetail = widget.schedule.scheduleDetailInfo!;

    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(
        scheduleDetail.startPeriodTimestamp ?? 0);
    bool canCancel =
        DateTime.now().add(Duration(hours: 2)).compareTo(startTime) < 0;
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
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 6),
            color: Colors.white,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${convertTimeStampToHour(scheduleDetail.startPeriodTimestamp ?? 0)}-${convertTimeStampToHour(scheduleDetail.endPeriodTimestamp ?? 0)}",
                      style: LettutorFontStyles.defaultAvatarText.copyWith(
                          color: Colors.black.withOpacity(
                            0.85,
                          ),
                          fontWeight: FontWeight.normal),
                    ),
                    canCancel
                        ? GestureDetector(
                            onTap: () {
                              if (canCancel) {
                                int? selectedValue = 1;

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: StatefulBuilder(
                                        builder: (context, update) {
                                      return Container(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            StateAvatar(
                                              foregroundRadius: 5,
                                              backgroundRadius: 30,
                                              dx: 46,
                                              displayTop:
                                                  teacher.isActivated ?? false,
                                              child: Image.network(
                                                teacher!.avatar ?? "",
                                              ),
                                            ),
                                            Text(
                                              "Lesson Time",
                                              style:
                                                  LettutorFontStyles.hintText,
                                            ),
                                            Text(
                                              DateFormat(
                                                "EEE, dd MMM yy",
                                              ).format(startTime),
                                              style: LettutorFontStyles
                                                  .meeting_date,
                                            ),
                                            Divider(),
                                            UserTitleHeader(
                                                "What was the reason you cancel this booking?"),
                                            DropdownButton(
                                                value: selectedValue,
                                                items: const [
                                                  DropdownMenuItem(
                                                    child: Text(
                                                        "Reschedule at another time"),
                                                    value: 1,
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(
                                                        "Busy at that time"),
                                                    value: 2,
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(
                                                        "Asked by the tutor"),
                                                    value: 3,
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text("Other"),
                                                    value: 4,
                                                  ),
                                                ],
                                                onChanged: (value) {
                                                  update(() {
                                                    selectedValue = value;
                                                  });
                                                }),
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: "Additonal Notes"),
                                              maxLines: 3,
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Later"),
                                      ),
                                      ElevatedButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            await ScheduleController
                                                .cancelBookedClass(
                                                    schedule.id ?? "",
                                                    cancelReasonID:
                                                        selectedValue ?? 1);

                                            if (widget.onCancelCallBack !=
                                                null) {
                                              widget.onCancelCallBack!();
                                            }
                                          },
                                          child: Text("Submit"))
                                    ],
                                    actionsAlignment: MainAxisAlignment.end,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.0),
                                  border: Border.all(color: Colors.red)),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                            ))
                        : const SizedBox(),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300)),
                child: ExpansionTile(
                  leading: Icon(
                    isExpand ? Icons.expand_more : Icons.chevron_right,
                    color: Colors.black.withOpacity(0.85),
                  ),
                  initiallyExpanded: true,
                  trailing: TextButton(
                    child: Text("Edit Request"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            final noteController = TextEditingController();
                            noteController.text = schedule.studentRequest ?? "";
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .7,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Special Request"),
                                          CloseButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ),
                                      Divider(),
                                      UserTitleHeader("Note"),
                                      TextFormField(
                                        maxLines: 8,
                                        maxLength: 200,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        controller: noteController,
                                      ),
                                      Text(
                                        "You can write in English or Vietnamese (Maximum 200 letters)",
                                        style: LettutorFontStyles.reviewText
                                            .copyWith(
                                                fontStyle: FontStyle.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    print(noteController.text);
                                    ScheduleController.updateStudentRequest(
                                            schedule.id ?? "",
                                            request: noteController.text)
                                        .then((value) {
                                      print("Result: $value");
                                      if (widget.onCancelCallBack != null) {
                                        widget.onCancelCallBack!();
                                      }
                                    });

                                    Navigator.pop(context);
                                  },
                                  child: Text("Submit"),
                                )
                              ],
                            );
                          });
                    },
                  ),
                  onExpansionChanged: (value) {
                    setState(() {
                      isExpand = value;
                    });
                  },
                  title: Text(
                    'Request for lesson',
                    style: LettutorFontStyles.request_text,
                  ),
                  childrenPadding: const EdgeInsets.all(16.0),
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 14),
                      child: Text(
                        schedule.studentRequest != null
                            ? schedule.studentRequest!
                            : 'Currently there are no requests for this class. Please write down any requests for the teacher.',
                        style: schedule.studentRequest != null
                            ? LettutorFontStyles.request_text
                            : LettutorFontStyles.no_request_text,
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: canCancel ? null : () {},
                child: Text('Go to meeting'),
              )
            ],
          )
        ],
      ),
    );
  }
}
