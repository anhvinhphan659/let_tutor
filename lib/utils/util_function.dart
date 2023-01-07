import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
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

Future displayMessage(BuildContext context,
    {Widget icon = const Icon(
      Icons.check_circle,
      color: Colors.green,
    ),
    String message = "Successfull"}) async {
  await showDialog(
    context: context,
    builder: (context) {
      //call update function
      Future.delayed(const Duration(milliseconds: 1000), () async {
        Navigator.pop(context);
      });
      return AlertDialog(
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Text(
                  message,
                  maxLines: 3,
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<DateTime?> showTimePickerSpinner(BuildContext context) async {
  DateTime? pickedTime;
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TimePickerSpinner(
            is24HourMode: true,
            isShowSeconds: false,
            minutesInterval: 30,
            onTimeChange: (value) {
              pickedTime = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                pickedTime = null;
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok"))
          ],
        );
      });

  return pickedTime;
}

String? isValidEmail(String? value) {
  if (value == null ||
      value.isEmpty ||
      !value.contains('@') ||
      !value.contains('.')) {
    return 'The input is not valid E-mail!';
  }
  return null;
}
