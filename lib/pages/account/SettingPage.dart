import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/pages/account/ProfilePage.dart';
import 'package:let_tutor/pages/auth/LoginPage.dart';
import 'package:let_tutor/pages/courses/ListCoursePage.dart';
import 'package:let_tutor/pages/schedule/HistorySchedulePage.dart';
import 'package:let_tutor/pages/schedule/ListSchedulePage.dart';
import 'package:let_tutor/pages/teachers/LettutorPageProfile.dart';

import 'package:let_tutor/utils/components/common.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigators = [
      {
        "icon": 'assets/icons/book-medical.svg',
        "screen": "Buy Lessons",
        "function": () {
          print('Buy Lessons');
        },
      },
      {
        "icon": 'assets/icons/key.svg',
        "screen": "Change Password",
        "function": () {},
      },
      {
        "icon": 'assets/icons/chalkboard-teacher.svg',
        "function": () {},
        "screen": "Tutor",
      },
      {
        "icon": 'assets/icons/calendar-check.svg',
        "function": () {
          PushTo(context: context, destination: ListSchedulePage());
        },
        "screen": "Schedule",
      },
      {
        "icon": 'assets/icons/history.svg',
        "screen": "History",
        "function": () {
          PushTo(context: context, destination: HistorySchedulePage());
        },
      },
      {
        "icon": 'assets/icons/graduation-cap.svg',
        "function": () {
          PushTo(context: context, destination: ListCoursePage());
        },
        "screen": "Courses",
      },
      {
        "icon": 'assets/icons/book-open.svg',
        "screen": "My Course",
        "function": () {},
      },
      {
        "icon": 'assets/icons/user-graduate.svg',
        "screen": "Become a tutor",
        "function": () {
          PushTo(context: context, destination: LettutorPageProfile());
        },
      },
      {
        "icon": 'assets/icons/sign-out-alt.svg',
        "screen": "Logout",
        "function": () {
          PushTo(context: context, destination: LoginPage());
        },
      },
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          height: 39,
          child: SvgPicture.asset(
            'assets/images/lettutor_logo.svg',
            fit: BoxFit.fitWidth,
          ),
        ),
        leadingWidth: 300,
        actions: [
          PopupMenuButton<int>(
              offset: Offset(0, 60),
              icon: Icon(Icons.flag_circle),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    child: Text('Option 1'),
                    value: 1,
                  ),
                  PopupMenuItem<int>(
                    child: Text('Option 2'),
                    value: 2,
                  ),
                  PopupMenuItem<int>(
                    child: Text('Option 3'),
                    value: 3,
                  ),
                ];
              }),
          IconButton(
            onPressed: () {
              BackToPrevious(context: context);
            },
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: ListView(children: [
        ListTile(
          onTap: () {
            PushTo(context: context, destination: ProfilePage());
          },
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 20,
          ),
          title: Text('Khanh Nguyen'),
        ),
        ...navigators.map(
          (e) => ListTile(
            onTap: e['function']! as Function(),
            leading: SizedBox(
                width: 32,
                height: 32,
                child: SvgPicture.asset(
                  e["icon"]!.toString(),
                  fit: BoxFit.fitHeight,
                )),
            title: Text(e["screen"]!.toString()),
          ),
        )
      ]),
    );
  }
}
