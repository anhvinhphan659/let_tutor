import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:let_tutor/utils/data/country.dart';
import 'package:let_tutor/utils/data/util_storage.dart';
import 'package:url_launcher/url_launcher.dart';

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

Country? getCountryByCodeName(String codeName) {
  for (var country in UtilStorage.countries) {
    if ((country.code ?? "") == codeName) {
      return country;
    }
  }
  return null;
}

String getLanguageName(String codeLanguage) {
  for (var country in UtilStorage.countries) {
    if (country.language != null) {
      if (country.language!.code == codeLanguage) {
        return country.language!.name ?? "";
      }
    }
  }
  return "";
}

Map<String, dynamic> getJsonFromToken(String token) {
  Map<String, dynamic> payload = Jwt.parseJwt(token);

  return payload;
}

Future<void> displayURL(String _url) async {
  if (!await launchUrl(Uri.parse(
    _url,
  ))) {
    throw 'Could not launch $_url';
  }
}
