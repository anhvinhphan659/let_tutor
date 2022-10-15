import 'package:flutter/material.dart';
import 'package:let_tutor/components/common.dart';
import 'package:let_tutor/utils/styles.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LettutorAppbar(),
      body: Container(
          child: Column(
        children: [
          Text(
            'Đặt lại mật khẩu',
            style: LettutorFontStyles.largeLabelText,
          ),
          Text(
            'Vui lòng nhập email để tìm kiếm tài khoản của bạn.',
            style: LettutorFontStyles.normalText,
          ),
          Text(
            'Email',
            style: LettutorFontStyles.normalText,
          ),
          TextField(
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)))),
          ),
          Container(
            decoration: BoxDecoration(
                color: LettutorColors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(6.0))),
            child: TextButton(
              child: Text(
                'Xác nhận',
                style:
                    LettutorFontStyles.normalText.copyWith(color: Colors.white),
              ),
              onPressed: () {},
            ),
          )
        ],
      )),
    );
  }
}
