import 'dart:ui' as ui;
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';

void main(List<String> args) async {
  await CountryCodes
      .init(); // Optionally, you may provide a `Locale` to get countrie's localizadName

  Locale l = const Locale.fromSubtags(languageCode: 'vi');

  final CountryDetails details = CountryCodes.detailsForLocale(l);
}
