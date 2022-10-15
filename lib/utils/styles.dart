import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LettutorColors {
  static Color primaryColor = const Color.fromRGBO(0, 112, 240, 1.0);
  static Color linkColor = const Color.fromRGBO(40, 106, 210, 1.0);
  static Color lightBlueColor = const Color.fromRGBO(24, 144, 255, 1.0);
  static Color grayColor = const Color.fromRGBO(164, 176, 190, 1.0);
  static Color lightGrayColor = const Color.fromRGBO(228, 228, 228, 1.0);
}

class LettutorFontStyles {
  static TextStyle normalText = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: 'Poppins, sans-serif',
      color: Colors.black.withOpacity(0.85),
      height: 1.45);
  static TextStyle formTitle = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins, sans-serif',
      color: LettutorColors.primaryColor,
      height: 1.45);
  static TextStyle formDescription = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins, sans-serif',
      height: 1.8);
  static TextStyle formLabel = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: 'Poppins, sans-serif',
      color: LettutorColors.grayColor,
      height: 1.2);
  static TextStyle largeLabelText = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.normal,
      fontFamily: 'Poppins, sans-serif',
      color: Colors.black.withOpacity(0.85),
      height: 1.45);
}
