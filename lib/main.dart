import 'dart:io';

import 'package:country_codes/country_codes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:let_tutor/handler/api_handler.dart';
import 'package:let_tutor/handler/auth/auth_controller.dart';
import 'package:let_tutor/handler/data_handler.dart';
import 'package:let_tutor/handler/http_override.dart';
import 'package:let_tutor/handler/user/user_controller.dart';
import 'package:let_tutor/models/user.dart';
import 'package:let_tutor/pages/auth/LoginPage.dart';
import 'package:let_tutor/utils/data/util_storage.dart';

void main() async {
  await initHandler();
  runApp(const MyApp());
}

Future initHandler() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await CountryCodes.init();

  await DataHandler.initial();
  //generate util storage
  UserController.getAllLearnTopic().then((value) {
    UtilStorage.learnTopics = value;
    print(value);
  });
  UserController.getAllTestPreparation().then((value) {
    UtilStorage.testPreparations = value;
    print(value);
  });

  // ByteData data =
  //     await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());
  // await ApiHandler.initial();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
