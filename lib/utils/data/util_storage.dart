import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:let_tutor/models/course/content_category.dart';
import 'package:let_tutor/models/user.dart';

import 'country.dart';

class UtilStorage {
  static late final List<LearnTopics> learnTopics;
  static late final List<TestPreparations> testPreparations;
  static late final List<Country> countries;
  static List<ContentCategory> contentCategories = [];

  static const String countryFilePath = "assets/files/country.json";

  static Future<void> initCountryList() async {
    String data = await rootBundle.loadString(countryFilePath);
    List<Country> countryList = <Country>[];
    dynamic jsonData = jsonDecode(data);

    for (var country in jsonData) {
      countryList.add(Country.fromJson(country));
    }

    print("Country loaded: ${countryList.length}");

    countries = countryList;
  }
}
