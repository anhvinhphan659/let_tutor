import 'package:flutter/material.dart';
import 'package:let_tutor/handler/user/user_controller.dart';
import 'package:let_tutor/pages/auth/ResetPasswordSuccessfullPage.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/styles/styles.dart';
import 'package:let_tutor/utils/util_function.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool isRequestSending = false;
  final TextEditingController _emailTxtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LettutorContainer(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
          color: Colors.white,
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Reset password',
                    style: LettutorFontStyles.largeLabelText,
                  ),
                ),
                Center(
                  child: Text(
                    'Please enter your email address to search for your account.',
                    style: LettutorFontStyles.normalText,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: LettutorFontStyles.normalText,
                  ),
                ),
                TextField(
                  controller: _emailTxtController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(6.0)))),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: LettutorColors.primaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(6.0))),
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 600),
                    opacity: isRequestSending ? 0.4 : 1.0,
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          isRequestSending
                              ? const CircularProgressIndicator()
                              : const SizedBox(),
                          Text(
                            'Send reset link',
                            style: LettutorFontStyles.normalText
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        String email = _emailTxtController.text;
                        //prevent multiple tap
                        if (isRequestSending) {
                          return;
                        }
                        if (email.isNotEmpty) {
                          setState(() {
                            isRequestSending = true;
                          });
                          bool result = false;
                          try {
                            result = await UserController.forgotPassword(email);
                          } catch (e) {
                            print(e);
                          }

                          setState(() {
                            isRequestSending = false;

                            print("set to default");
                          });
                          if (result) {
                            _emailTxtController.clear();
                            PushTo(
                              context: context,
                              destination: const ResetPasswordSuccessfullPage(),
                            );
                          }
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
