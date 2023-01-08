import 'package:flutter/material.dart';
import 'package:let_tutor/pages/auth/LoginPage.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/styles/styles.dart';

class ResetPasswordSuccessfullPage extends StatelessWidget {
  const ResetPasswordSuccessfullPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        PushTo(context: context, destination: LoginPage());
        return true;
      },
      child: LettutorContainer(
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
                    'Check your inbox for a link to reset your password.',
                    style: LettutorFontStyles.normalText,
                  ),
                ),
              ],
            ),
          ),
        ),
        isLogin: false,
      ),
    );
  }
}
