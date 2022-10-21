import 'package:flutter/material.dart';
import 'package:let_tutor/utils/styles/styles.dart';

class BookingTable extends StatelessWidget {
  const BookingTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(width: 1.0, color: Colors.black.withOpacity(0.85)),
      children: [
        TableRow(
          children: [
            Text(''),
            Text('26/10'),
            Text('27/10'),
            Text('28/10'),
            Text('29/10'),
            Text('30/10'),
            Text('31/10'),
            Text('1/11'),
            Text('2/11'),
          ],
        ),
        TableRow(
          children: [
            Text('10:00-10:25'),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
          ],
        ),
        TableRow(
          children: [
            Text('10:00-10:25'),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
          ],
        ),
        TableRow(
          children: [
            Text('10:00-10:25'),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
          ],
        ),
        TableRow(
          children: [
            Text('10:00-10:25'),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
          ],
        ),
        TableRow(
          children: [
            Text('10:00-10:25'),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
            Text('     '),
          ],
        ),
      ],
    );
  }
}
