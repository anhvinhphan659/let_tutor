import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/handler/schedule/schedule_controller.dart';
import 'package:let_tutor/handler/user/user_controller.dart';
import 'package:let_tutor/models/schedule/schedule.dart';
import 'package:let_tutor/models/schedule/teacher_schedule.dart';
import 'package:let_tutor/pages/account/ProfilePage.dart';
import 'package:let_tutor/utils/styles/styles.dart';

DateTime getStartDateOfWeek(DateTime dt) {
  return dt.subtract(Duration(days: dt.weekday - DateTime.monday));
}

List<DateTime> getDatesOfWeek(DateTime startTime) {
  return List.generate(7, (range) => startTime.add(Duration(days: range)));
}

String getDisplayTitle(DateTime initialDate) {
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  var days = getDatesOfWeek(initialDate);
  var start = days[0];
  var end = days[6];
  String ret = months[start.month - 1].substring(0, 3);
  if (end.month != start.month) {
    ret += " - ${months[end.month - 1].substring(0, 3)}";
  }
  ret += ', ${end.year}';
  return ret;
}

List<String> getListPeriod() {
  List<String> periods = [];
  DateTime start = DateTime(2000, 1, 1, 0, 0);
  DateTime end = start.add(const Duration(days: 1));
  DateFormat df = DateFormat("HH:mm");
  while (start.isBefore(end)) {
    DateTime endPeriod = start.add(const Duration(minutes: 25));
    periods.add("${df.format(start)}-${df.format(endPeriod)}");
    start = start.add(const Duration(minutes: 30));
  }
  return periods;
}

// ignore: must_be_immutable
class BookingTable extends StatelessWidget {
  DateTime? initialDate;
  Function? callBack;

  List<TeacherSchedule> teacherSchedule;
  BookingTable(
      {Key? key,
      this.initialDate,
      this.teacherSchedule = const <TeacherSchedule>[],
      this.callBack})
      : super(key: key);

  static const daysInWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static List<String> periods = getListPeriod();

  // ignore: constant_identifier_names
  static const double DATA_COLUMN_WIDTH = 80.0;
  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    initialDate = initialDate ?? DateTime.now();
    var DatesInWeek = getDatesOfWeek(initialDate!);

    Map<String, List<Widget>> tableDataMap = {};

    for (String period in periods) {
      tableDataMap[period] = [
        TitleColumnCell(content: period),
        ...daysInWeek.map((e) => DataCell())
      ];
    }

    for (var schedule in teacherSchedule) {
      DateTime startPeriod =
          DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp ?? 0);
      DateTime endPeriod =
          DateTime.fromMillisecondsSinceEpoch(schedule.endTimestamp ?? 0);
      DateFormat df = DateFormat("HH:mm");
      String period = "${df.format(startPeriod)}-${df.format(endPeriod)}";
      bool canBook = DateTime.now().compareTo(startPeriod) < 0;
      bool isReversed = schedule.isReversedClass();

      if (tableDataMap[period] != null) {
        bool isBooked =
            schedule.getListUserID().contains(UserController.currentUser.id);
        //if schedule is booked or is reversed
        if (isBooked || isReversed) {
          canBook = false;
        }

        tableDataMap[period]![(startPeriod.day - initialDate!.day) % 7 + 1] =
            DataCell(
                child: GestureDetector(
          onTap: () {
            if (canBook) {
              String bookingTime =
                  "$period ${DateFormat("EEEE, d MMMM yyyy").format(startPeriod)}";
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  elevation: 1.0,
                  title: Text("Booking details"),
                  content: Container(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserTitleHeader("Booking Time", isCompulsory: false),
                        Container(
                            margin: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(238, 234, 255, 1.0),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Text(
                              bookingTime,
                              style: LettutorFontStyles.bookingTimeText,
                            )),
                        UserTitleHeader("Note", isCompulsory: false),
                        TextFormField(
                          maxLines: 5,
                          minLines: 4,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: Color(0xFF40A9FF),
                              ),
                            ),
                          ),
                          controller: _noteController,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel")),
                    ElevatedButton(
                        onPressed: () async {
                          print(schedule.getListScheduleId());
                          bool result = await ScheduleController.bookAClass(
                              schedule.getListScheduleId(),
                              _noteController.text);
                          if (result) {
                            if (callBack != null) {
                              callBack!();
                            }

                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Booking details"),
                                      content: Container(
                                          child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.check_circle_sharp,
                                            color: Colors.green,
                                          ),
                                          Text(
                                            "Booking success",
                                            style: LettutorFontStyles.normalText
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          Text(
                                            "Check your mail's inbox to see detail order",
                                            style:
                                                LettutorFontStyles.normalText,
                                          )
                                        ],
                                      )),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Done"))
                                      ],
                                    ));
                          }

                          _noteController.clear();
                        },
                        child: Text(">> Book")),
                  ],
                ),
              );
            }
          },
          child: BookingCell(
            isBooked: isBooked,
            canBook: canBook,
            isReversed: isReversed,
          ),
        ));
      }
    }

    //TODO: custom data here

    return Table(
      columnWidths: const {
        0: FixedColumnWidth(100),
        1: FixedColumnWidth(DATA_COLUMN_WIDTH),
        2: FixedColumnWidth(DATA_COLUMN_WIDTH),
        3: FixedColumnWidth(DATA_COLUMN_WIDTH),
        4: FixedColumnWidth(DATA_COLUMN_WIDTH),
        5: FixedColumnWidth(DATA_COLUMN_WIDTH),
        6: FixedColumnWidth(DATA_COLUMN_WIDTH),
        7: FixedColumnWidth(DATA_COLUMN_WIDTH),
      },
      border:
          TableBorder.all(width: 1.0, color: Color.fromRGBO(64, 64, 64, 1.0)),
      children: [
        TableRow(
          children: [
            TitleColumnCell(),
            ...DatesInWeek.map(
              (e) => TitleRowCell(e),
            ),
          ],
        ),
        ...tableDataMap.keys.map(
          (e) => TableRow(
            children: tableDataMap[e],
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget TitleColumnCell({String content = ""}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        color: const Color.fromRGBO(249, 249, 249, 1.0),
        padding: const EdgeInsets.all(6.0),
        child: Text(content),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget TitleRowCell(DateTime dt) {
    return TableCell(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat('dd/MM').format(dt)),
            Text(daysInWeek[dt.weekday - 1]),
          ],
        ),
      ),
    );
  }

  Widget DataCell({Widget child = const Text("")}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(4.0),
          child: child),
    );
  }
}

class BookingCell extends StatelessWidget {
  final bool isBooked;
  final bool canBook;
  final bool isReversed;
  const BookingCell(
      {Key? key,
      this.isBooked = false,
      this.canBook = true,
      this.isReversed = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //handle display
    String displayText = "Book";
    Color backgroundColor = Colors.blue;
    Color textColor = Colors.white;
    Color borderColor = Colors.white;
    if (isReversed) {
      displayText = "Reserved";
      backgroundColor = Colors.white;
      textColor = Colors.grey;
    } else {
      if (!canBook) {
        backgroundColor = Colors.grey.shade300;
        textColor = borderColor = Colors.grey.shade400;
      }
    }
    if (isBooked) {
      displayText = "Booked";
      backgroundColor = Colors.white;
      borderColor = Colors.white;
      textColor = Colors.green;
    }
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: borderColor)),
      child: Text(
        displayText,
        style: TextStyle(color: textColor, fontSize: 12),
      ),
    );
  }
}
