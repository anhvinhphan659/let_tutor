import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/pages/account/ProfilePage.dart';
import 'package:let_tutor/pages/account/SettingPage.dart';
import 'package:let_tutor/utils/styles/styles.dart';

import '../../utils/components/common.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldPasswordController = TextEditingController();

  final _newPasswordController = TextEditingController();

  final _renewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        UserTitleHeader("Password"),
                        CustomTextField(_oldPasswordController),
                        UserTitleHeader("New Password"),
                        CustomTextField(_newPasswordController),
                        UserTitleHeader("Confirm Password"),
                        CustomTextField(_renewPasswordController),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                child: Text("Change Password"))
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
