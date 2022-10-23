import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LettutorColors {
  static Color primaryColor = const Color.fromRGBO(0, 112, 240, 1.0);
  static Color linkColor = const Color.fromRGBO(40, 106, 210, 1.0);
  static Color lightBlueColor = const Color.fromRGBO(24, 144, 255, 1.0);
  static Color blueColor = const Color.fromRGBO(0, 113, 240, 1.0);
  static Color grayColor = const Color.fromRGBO(164, 176, 190, 1.0);
  static Color lightGrayColor = const Color.fromRGBO(228, 228, 228, 1.0);
  static Color blackColor = const Color.fromRGBO(42, 52, 83, 1.0);
  static Color unselectedBackgroundColor =
      const Color.fromRGBO(228, 230, 235, 1.0);
  static Color selectedBackgroundColor =
      const Color.fromRGBO(221, 234, 255, 1.0);
}

class LettutorFontStyles {
//common
  static TextStyle h2Title = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins, sans-serif',
      color: Colors.black.withOpacity(0.85),
      height: 1.45);
  //-----------------------------------------
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

  //---------------------------------------//
  //detail pages
  static TextStyle searchTitle = TextStyle(
      fontSize: 29,
      fontWeight: FontWeight.w700,
      fontFamily: 'Poppins, sans-serif',
      color: Colors.black.withOpacity(0.85),
      height: 1.45);

  static TextStyle tagUnSelectedText = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto, sans-serif',
      color: Colors.black.withOpacity(0.85),
      height: 1.45);
  static TextStyle tagSelectedText = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto, sans-serif',
      color: LettutorColors.blueColor,
      height: 1.45);

  static TextStyle teacherNameText = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins, sans-serif',
      color: LettutorColors.blackColor,
      height: 1.45);
  static TextStyle descriptionText = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto, sans-serif',
      color: Color.fromRGBO(0, 0, 0, 0.6),
      height: 1.45);

  static TextStyle hintText = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto, sans-serif',
      color: Color.fromRGBO(0, 0, 0, 0.85),
      height: 1.45);

//---------------------------------------//
//detail pages
  static TextStyle headerTeacherDetail = const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto, sans-serif',
      color: Color.fromRGBO(0, 0, 0, 0.85),
      height: 1.45);
  static TextStyle contentText = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto, sans-serif',
      color: Color.fromRGBO(120, 120, 120, 1.0),
      height: 1.45);
  static TextStyle h5Text = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Roboto, sans-serif',
      color: Color.fromRGBO(0, 0, 0, 0.85),
      height: 1.45);

  //---------------------------------------//
//detail pages
  static TextStyle courseTitle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Roboto, sans-serif',
      color: Color.fromRGBO(0, 0, 0, 0.85),
      height: 1.45);

  static TextStyle courseContent = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto, sans-serif',
      color: Color.fromRGBO(120, 120, 120, 1.0),
      height: 1.45);
}
