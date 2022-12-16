import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/handler/user/user_controller.dart';
import 'package:let_tutor/models/user.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/StateAvatar.dart';
import 'package:let_tutor/utils/components/teachers/TeacherCard.dart';
import 'package:let_tutor/utils/data/util_storage.dart';
import 'package:let_tutor/utils/styles/styles.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'SettingPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    UserController.getUserInformation().then(
      (value) {
        setState(() {
          user = UserController.currentUser;
        });
      },
    );
    print("Init state");
    super.initState();
  }

  final levelOptions = {
    "BEGINNER": "Pre A1 (Beginner)",
    "HIGHER_BEGINNER": "A1 (Higher Beginner)",
    "PRE_INTERMEDIATE": "A2 (Pre-Intermediate)",
    "INTERMEDIATE": "B1 (Intermediate)",
    "UPPER_INTERMEDIATE": "B2 (Upper-Intermediate)",
    "ADVANCED": "C1 (Advanced)",
    "PROFICIENCY": "C2 (Proficiency)",
  };

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _studyController = TextEditingController();
  User user = UserController.currentUser;
  String _levelSelected = "BEGINNER";
  DateTime _birthdaySelected = DateTime.now();
  var expandTab = false;
  @override
  Widget build(BuildContext context) {
    // print(user.toJson());
    print("build");

    List<LearnTopics> initValue = [];
    initValue.addAll(user.learnTopics ?? []);
    initValue.addAll((user.testPreparations ?? []));
    print(initValue);
    //set up display
    _studyController.text = user.studySchedule ?? "";
    _levelSelected = user.level ?? "";
    _birthdaySelected = DateTime.parse(user.birthday ?? "");

    Widget avatarWidget = DefaultAvatar(teacherName: user.name ?? "");
    if (user.avatar != null) {
      if (!user.avatar!.contains("avatar-default")) {
        avatarWidget = Image.network(
          user.avatar!,
          fit: BoxFit.fill,
        );
      }
    }
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
              icon: Icon(
                Icons.flag_circle,
                color: Colors.black,
              ),
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
              PushTo(context: context, destination: SettingPage());
            },
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
        child: ListView(children: [
          Card(
            elevation: 2.0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(top: BorderSide(color: Colors.blue, width: 4))),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(35.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: StateAvatar(
                            backgroundTopColor: Colors.blue,
                            backgroundRadius: 65,
                            foregroundRadius: 15,
                            dx: 94,
                            topWidget: const Icon(
                              Icons.create,
                              size: 18,
                              color: Colors.white,
                            ),
                            displayTop: true,
                            child: avatarWidget,
                          ),
                        ),
                        Text(
                          user.name ?? "",
                          style: LettutorFontStyles.h3Title,
                        ),
                        Text(
                          'Account ID: ${user.id ?? ""}',
                          maxLines: 2,
                          style: LettutorFontStyles.normalText
                              .copyWith(color: Colors.black.withOpacity(0.54)),
                        ),
                        TextButton(
                            onPressed: () {}, child: Text('Others review you'))
                      ],
                    ),
                  ),
                  Container(
                    color: const Color.fromRGBO(245, 246, 250, 1.0),
                    child: ExpansionTile(
                      trailing: const SizedBox(),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      backgroundColor: Colors.white,
                      childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 25),
                      title: Text(
                        'Account',
                        style: LettutorFontStyles.normalText,
                      ),
                      children: [
                        UserTitleHeader("Name"),
                        CustomTextField(_nameController,
                            initialText: user.name!),
                        UserTitleHeader("Email Address"),
                        CustomTextField(_emailController,
                            enabled: false, initialText: user.email!),
                        UserTitleHeader("Country"),
                        TextField(),
                        UserTitleHeader("Phone number"),
                        CustomTextField(_phoneController,
                            initialText: user.phone!, enabled: false),
                        user.isPhoneActivated!
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 7.0),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(246, 255, 237, 1.0),
                                  border: Border.all(
                                      color:
                                          Color.fromRGBO(183, 235, 143, 1.0)),
                                ),
                                child: Text(
                                  'Verify',
                                  style: LettutorFontStyles.descriptionText
                                      .copyWith(
                                    color: Color.fromRGBO(56, 158, 13, 1.0),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        UserTitleHeader("Birthday"),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: Color(0xFFD9D9D9),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(DateFormat('y/M/d')
                                  .format(_birthdaySelected)),
                              GestureDetector(
                                  onTap: () async {
                                    DateTime newDateSelected =
                                        await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now()
                                                    .subtract(const Duration(
                                                        days: 365 * 23)),
                                                firstDate: DateTime(1900, 1, 1),
                                                lastDate: DateTime.now()) ??
                                            _birthdaySelected;

                                    setState(() {
                                      _birthdaySelected = newDateSelected;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 14,
                                  ))
                            ],
                          ),
                        ),
                        UserTitleHeader("My Level"),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: Color(0xFFD9D9D9),
                            ),
                          ),
                          child: DropdownButton(
                              underline: const SizedBox(),
                              isExpanded: true,
                              value: _levelSelected,
                              items: (levelOptions.keys)
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(levelOptions[e]!),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) => setState(() {
                                    _levelSelected = value ?? "";
                                  })),
                        ),
                        UserTitleHeader("Want to learn"),
                        Container(
                          decoration: BoxDecoration(),
                          child: MultiSelectDialogField(
                            items: [
                              ...UtilStorage.learnTopics.map(
                                (e) => MultiSelectItem(e, e.name ?? ""),
                              ),
                              ...UtilStorage.testPreparations.map(
                                (e) => MultiSelectItem(e, e.name ?? ""),
                              ),
                            ],
                            initialValue: initValue,
                            onConfirm: (result) {
                              // print(result);
                            },
                          ),
                        ),
                        UserTitleHeader("Study Schedule"),
                        TextFormField(
                            minLines: 4,
                            maxLines: 5,
                            controller: _studyController,
                            // initialValue: user.studySchedule ?? "",
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFFD9D9D9),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFF40A9FF),
                                ),
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      //call update function
                                      Future.delayed(
                                          const Duration(milliseconds: 1000),
                                          () async {
                                        Navigator.pop(context);
                                      });
                                      return AlertDialog(
                                          content: Row(
                                        children: const [
                                          Icon(
                                            Icons.verified,
                                          ),
                                          Text("Successfull")
                                        ],
                                      ));
                                    },
                                  );
                                },
                                child: Text('Save changes')),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget UserTitleHeader(String title, {bool isCompulsory = true}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    child: RichText(
      text: TextSpan(children: [
        isCompulsory
            ? TextSpan(
                text: '* ',
                style:
                    LettutorFontStyles.normalText.copyWith(color: Colors.red))
            : const TextSpan(text: ''),
        TextSpan(text: title, style: LettutorFontStyles.h5Text)
      ]),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget CustomTextField(TextEditingController controller,
    {String initialText = "", bool enabled = true}) {
  controller.text = initialText;
  return TextField(
    enabled: enabled,
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: const BorderSide(
          color: Color(0xFFD9D9D9),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: const BorderSide(
          color: Color(0xFF40A9FF),
        ),
      ),
    ),
  );
}
