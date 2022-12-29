import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/handler/auth/auth_controller.dart';
import 'package:let_tutor/pages/account/ProfilePage.dart';
import 'package:let_tutor/pages/account/SettingPage.dart';
import 'package:let_tutor/utils/styles/styles.dart';
import 'package:let_tutor/utils/util_function.dart';

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

  String _newPassword = "";

  bool _isPasswordHandling = false;

  Widget PasswordTextField(TextEditingController controller,
      {String initialText = "",
      bool enabled = true,
      Function(String?)? setPassword,
      String? oldPassword}) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      obscureText: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) {
        if (setPassword != null) {
          print("Password set: " + value);
          setPassword(value);
        }
      },
      validator: (value) {
        if (value != null) {
          if (value.isEmpty) {
            return "Please input your password";
          }
          if (value.length < 6) {
            return "Password length must be at least 6 characters";
          }
          if (oldPassword != null) {
            if (oldPassword.compareTo(value) != 0) {
              return "The two passwords that you entered do not match";
            }
          }
        }
        return null;
      },
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
        errorMaxLines: 3,
      ),
    );
  }

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
                        'Change password',
                        style: LettutorFontStyles.h5Title,
                      ),
                      children: [
                        UserTitleHeader("Password"),
                        PasswordTextField(
                          _oldPasswordController,
                          enabled: !_isPasswordHandling,
                        ),
                        UserTitleHeader(
                          "New Password",
                        ),
                        PasswordTextField(
                          _newPasswordController,
                          enabled: !_isPasswordHandling,
                          setPassword: (value) {
                            print("Get value: " + value!);
                            setState(() {
                              _newPassword = value ?? "";
                            });
                          },
                        ),
                        UserTitleHeader(
                          "Confirm Password",
                        ),
                        PasswordTextField(_renewPasswordController,
                            enabled: !_isPasswordHandling,
                            oldPassword: _newPassword),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  String oldPassword =
                                      _oldPasswordController.text;
                                  String reNewPassword =
                                      _renewPasswordController.text;
                                  if (oldPassword.length >= 6 &&
                                      reNewPassword.length >= 6 &&
                                      _newPassword.length >= 6) {
                                    if (reNewPassword.compareTo(_newPassword) ==
                                        0) {
                                      setState(() {
                                        _isPasswordHandling = true;
                                      });
                                      bool result =
                                          await AuthController.changePassword(
                                              oldPassword, _newPassword);

                                      if (result) {
                                        _oldPasswordController.clear();
                                        _newPasswordController.clear();
                                        _renewPasswordController.clear();
                                        // ignore: use_build_context_synchronously
                                        await displayMessage(context,
                                            message:
                                                "Change password successfully");
                                      }

                                      print("Result: " + result.toString());
                                    }
                                  }
                                  setState(() {
                                    _isPasswordHandling = false;
                                  });

                                  print("Error in input");
                                },
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
