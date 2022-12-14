import 'package:country_codes/country_codes.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String? getCountryNameFromCode(String countryCode) {
  countryCode = countryCode.toLowerCase();
  String countryName = "";
  try {
    countryName = CountryCodes.name(
            locale: Locale(countryCode, countryCode.toUpperCase())) ??
        "";
  } catch (e) {
    print(e);
  }
  return countryName;
}

String convertTimeStampToHour(int timeStamp) {
  DateTime dt = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return DateFormat("HH:mm").format(dt);
}

String getDifferenceTime(DateTime start, {DateTime? end}) {
  end ??= DateTime.now();
  Duration diff = end.difference(start);
  String ret = "";
  if (diff.inMinutes > 0) {
    int minutes = diff.inMinutes;
    ret = "$minutes minute${minutes > 1 ? "s" : ""}";
  }
  if (diff.inHours > 0) {
    int hours = diff.inHours;
    ret = "$hours hour${hours > 1 ? "s" : ""}";
  }
  if (diff.inDays > 0) {
    int days = diff.inDays;
    int weeks = (days / 7).floor();
    int months = (days / 30).floor();
    int years = (days / 365.25).floor();
    ret = "$days day${days > 0 ? "s" : ""}";
    if (weeks > 0) {
      ret = "$weeks week${weeks > 0 ? "s" : ""}";
    }
    if (months > 0) {
      ret = "$months week${months > 0 ? "s" : ""}";
    }
    if (years > 0) {
      ret = "$years week${years > 0 ? "s" : ""}";
    }
  }

  return ret;
}
