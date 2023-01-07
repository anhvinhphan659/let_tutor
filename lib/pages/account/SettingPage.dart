import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:let_tutor/handler/course/course_controller.dart';
import 'package:let_tutor/handler/data_handler.dart';
import 'package:let_tutor/handler/user/user_controller.dart';
import 'package:let_tutor/models/user.dart';
import 'package:let_tutor/pages/account/ChangePasswordPage.dart';
import 'package:let_tutor/pages/account/ProfilePage.dart';
import 'package:let_tutor/pages/auth/LoginPage.dart';
import 'package:let_tutor/pages/courses/ListCoursePage.dart';
import 'package:let_tutor/pages/schedule/HistorySchedulePage.dart';
import 'package:let_tutor/pages/schedule/ListSchedulePage.dart';
import 'package:let_tutor/pages/teachers/LettutorPageProfile.dart';
import 'package:let_tutor/pages/teachers/ListTeacherPage.dart';

import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/StateAvatar.dart';
import 'package:let_tutor/utils/components/teachers/TeacherCard.dart';
import 'package:let_tutor/utils/data/util_storage.dart';
import 'package:let_tutor/utils/styles/styles.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = UserController.currentUser;
    Widget avatarWidget = DefaultAvatar(teacherName: user.name ?? "");
    if (user.avatar != null) {
      if (!user.avatar!.contains("avatar-default")) {
        avatarWidget = Image.network(
          user.avatar!,
          fit: BoxFit.cover,
        );
      }
    }
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
        "function": () {
          PushTo(context: context, destination: ChangePasswordPage());
        },
      },
      {
        "icon": 'assets/icons/chalkboard-teacher.svg',
        "function": () {
          PushTo(context: context, destination: ListTeacherPage());
        },
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
          CourseController.getAllContentCategory().then((value) {
            UtilStorage.contentCategories = value;
            print("Category get: " + value.length.toString());
          });
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
          _logOutHandler();
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
              offset: const Offset(0, 60),
              icon: const Icon(Icons.flag_circle),
              itemBuilder: (context) {
                return const [
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
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: ListView(children: [
        ListTile(
          onTap: () {
            UserController.getUserInformation();
            PushTo(context: context, destination: ProfilePage());
          },
          leading: StateAvatar(
            backgroundRadius: 20,
            child: avatarWidget,
          ),
          title: Text(user.name ?? "", style: LettutorFontStyles.settingText),
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
                  color: Colors.blue,
                )),
            title: Text(
              e["screen"]!.toString(),
              style: LettutorFontStyles.settingText,
            ),
          ),
        )
      ]),
    );
  }

  Future<void> _logOutHandler() async {
    String? googleLoginEmail = await DataHandler.getData("googleLoginEmail");
    if (googleLoginEmail != null) {
      print("Sign out google email login");
      print("Email: " + googleLoginEmail);
      GoogleSignIn().signOut();
    }
    await DataHandler.removeKey("Email");
    await DataHandler.removeKey("Password");
    await DataHandler.removeKey("accessToken");
    await DataHandler.removeKey("refreshToken");
  }
}
