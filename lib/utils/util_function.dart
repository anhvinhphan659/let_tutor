import 'package:country_codes/country_codes.dart';
import 'package:flutter/cupertino.dart';

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
