import 'package:flutter/material.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/styles/styles.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailTxtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LettutorContainer(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
          color: Colors.white,
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Đặt lại mật khẩu',
                    style: LettutorFontStyles.largeLabelText,
                  ),
                ),
                Center(
                  child: Text(
                    'Vui lòng nhập email để tìm kiếm tài khoản của bạn.',
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
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
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
                  child: TextButton(
                    child: Text(
                      'Xác nhận',
                      style: LettutorFontStyles.normalText
                          .copyWith(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          )),
    );
  }
}
