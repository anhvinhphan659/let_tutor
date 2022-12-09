import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/handler/auth/auth_controller.dart';
import 'package:let_tutor/handler/user/user_controller.dart';
import 'package:let_tutor/utils/components/common.dart';

import 'package:let_tutor/pages/auth/ForgotPasswordPage.dart';
import 'package:let_tutor/pages/auth/RegisterPage.dart';
import 'package:let_tutor/pages/teachers/ListTeacherPage.dart';
import 'package:let_tutor/utils/data/util_storage.dart';
import 'package:let_tutor/utils/styles/styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameTxtController = TextEditingController();
  final TextEditingController _passwordTxtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LettutorAppBar(isLogin: false),
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isSmallDevice = constraints.maxWidth >= 600;

            var image = Image.asset(
              'assets/images/background_lettutor.png',
              fit: BoxFit.fitWidth,
            );
            var content = Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: isSmallDevice
                      ? Border.all(
                          width: 1.0, color: LettutorColors.lightGrayColor)
                      : Border.all(width: 0.0, color: Colors.white),
                  borderRadius: isSmallDevice
                      ? const BorderRadius.all(Radius.circular(39.5))
                      : const BorderRadius.all(Radius.circular(0.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Đăng nhập",
                      style: LettutorFontStyles.formTitle,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Phát triển kỹ năng tiếng Anh nhanh nhất bằng cách học 1 kèm 1 trực tuyến theo mục tiêu và lộ trình dành cho riêng bạn.',
                      style: LettutorFontStyles.formDescription,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Text(
                      'ĐỊA CHỈ EMAIL',
                      style: LettutorFontStyles.formLabel,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: "mail@example.com",
                      ),
                      controller: _usernameTxtController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                    child:
                        Text('MẬT KHẨU', style: LettutorFontStyles.formLabel),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      controller: _passwordTxtController,
                      obscureText: true,
                      autocorrect: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextButton(
                      child: Text('Quên mật khẩu?',
                          style: LettutorFontStyles.normalText.copyWith(
                            color: LettutorColors.lightBlueColor,
                          )),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage()));
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: LettutorColors.primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0))),
                    child: TextButton(
                      onPressed: () async {
                        var loginStatus = await AuthController.login(
                            _usernameTxtController.text,
                            _passwordTxtController.text);

                        if (loginStatus == LOGIN_STATUS.SUCCESSFUL) {
                          PushTo(
                              context: context,
                              destination: const ListTeacherPage());
                        }
                      },
                      child: Center(
                        child: Text(
                          "ĐĂNG NHẬP",
                          style: LettutorFontStyles.formDescription.copyWith(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 34.0),
                    child: Center(
                      child: Text(
                        'Hoặc tiếp tục với',
                        style: LettutorFontStyles.normalText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.facebook)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.zoom_in)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.phone_android_outlined)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Chưa có tài khoản?',
                          style: LettutorFontStyles.normalText,
                        ),
                        TextButton(
                          child: Text('Đăng ký',
                              style: LettutorFontStyles.normalText.copyWith(
                                color: LettutorColors.lightBlueColor,
                              )),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );

            if (isSmallDevice) {
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(30.0),
                child: ListView(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            constraints: const BoxConstraints(maxWidth: 350),
                            child: content),
                        Expanded(child: image),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Container(
              color: Colors.white,
              child: ListView(
                children: [image, content],
              ),
            );
          },
        ));
  }
}
