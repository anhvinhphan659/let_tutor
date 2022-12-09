import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/utils/styles/styles.dart';

DateTime getStartDateOfWeek(DateTime dt) {
  return dt.subtract(Duration(days: dt.weekday - DateTime.monday));
}

List<DateTime> getDatesOfWeek(DateTime startTime) {
  if (startTime.weekday != DateTime.monday) {
    startTime = getStartDateOfWeek(startTime);
  }
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

// ignore: must_be_immutable
class BookingTable extends StatefulWidget {
  DateTime? initialDate;
  BookingTable({Key? key, this.initialDate}) : super(key: key);

  @override
  State<BookingTable> createState() => _BookingTableState();
}

class _BookingTableState extends State<BookingTable> {
  static const daysInWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  DateTime? initialDate;
  @override
  void initState() {
    print("Widget initial: " + widget.initialDate.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initialDate = widget.initialDate ?? DateTime.now();
    var DatesInWeek = getDatesOfWeek(initialDate!);
    print(DatesInWeek);
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(80),
        1: FixedColumnWidth(50),
        2: FixedColumnWidth(50),
        3: FixedColumnWidth(50),
        4: FixedColumnWidth(50),
        5: FixedColumnWidth(50),
        6: FixedColumnWidth(50),
        7: FixedColumnWidth(50),
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
        TableRow(
          children: [
            TitleColumnCell(content: '10:00-10:25'),
            DataCell(
              child: BookingCell(
                isBooked: true,
              ),
            ),
            DataCell(child: BookingCell()),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
          ],
        ),
        TableRow(
          children: [
            TitleColumnCell(content: '10:00-10:25'),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
          ],
        ),
        TableRow(
          children: [
            TitleColumnCell(content: '10:00-10:25'),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
          ],
        ),
        TableRow(
          children: [
            TitleColumnCell(content: '10:00-10:25'),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
          ],
        ),
        TableRow(
          children: [
            TitleColumnCell(content: '10:00-10:25'),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
            DataCell(),
          ],
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
  const BookingCell({Key? key, this.isBooked = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: isBooked ? Colors.grey.shade300 : Colors.blue,
          borderRadius: BorderRadius.circular(16.0)),
      child: Text(
        'Book',
        style: TextStyle(
          color: isBooked ? Colors.grey : Colors.white,
        ),
      ),
    ));
  }
}
