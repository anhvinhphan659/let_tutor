import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/handler/auth/auth_controller.dart';
import 'package:let_tutor/handler/course/course_controller.dart';
import 'package:let_tutor/handler/user/user_controller.dart';
import 'package:let_tutor/pages/teachers/ListTeacherPage.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/pages/auth/LoginPage.dart';
import 'package:let_tutor/utils/data/util_storage.dart';
import 'package:let_tutor/utils/styles/styles.dart';
import 'package:let_tutor/utils/util_function.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isRequestSending = false;
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
                      "Start learning with LetTutor",
                      style: LettutorFontStyles.formTitle,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Become fluent faster through one on one video chat lessons tailored to your goals.',
                      style: LettutorFontStyles.formDescription,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Text(
                      'EMAIL',
                      style: LettutorFontStyles.formLabel,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    child: TextFormField(
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: isValidEmail,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                    child:
                        Text('PASSWORD', style: LettutorFontStyles.formLabel),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      controller: _passwordTxtController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please input your Password!';
                        }
                        return null;
                      },
                      obscureText: true,
                      autocorrect: false,
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(seconds: 0),
                    opacity: isRequestSending ? 0.3 : 1.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: LettutorColors.primaryColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6.0))),
                      child: TextButton(
                        onPressed: () async {
                          String email = _usernameTxtController.text;
                          String password = _passwordTxtController.text;
                          if (password.isEmpty || isValidEmail(email) != null) {
                            return;
                          }
                          setState(() {
                            isRequestSending = true;
                          });
                          try {
                            bool result = await AuthController.registerAccount(
                                email, password);
                            setState(() {
                              isRequestSending = false;
                            });
                            print("Sign up: " + result.toString());
                            if (result) {
                              _usernameTxtController.clear();
                              _passwordTxtController.clear();
                              PushTo(
                                  context: context,
                                  destination: const LoginPage());
                            }
                          } catch (e) {
                            //
                          }
                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isRequestSending
                                  ? const CircularProgressIndicator()
                                  : const SizedBox(),
                              Text(
                                "SIGN UP",
                                style:
                                    LettutorFontStyles.formDescription.copyWith(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 34.0),
                    child: Center(
                      child: Text(
                        'Or continue with',
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
                            onPressed: () {
                              facebookSignInHandle();
                            },
                            icon: SvgPicture.asset(
                              "assets/icons/facebook-logo.svg",
                              fit: BoxFit.fitHeight,
                              height: 60,
                            )),
                        IconButton(
                            onPressed: () async {
                              var res = await googleSignInHandle();
                              if (res) {
                                UserController.getUserInformation();
                                CourseController.getAllContentCategory()
                                    .then((value) {
                                  UtilStorage.contentCategories = value;
                                });

                                print("Go to list teacher page");

                                PushTo(
                                    context: context,
                                    destination: ListTeacherPage());
                              }
                            },
                            icon: SvgPicture.asset(
                              "assets/icons/google-logo.svg",
                              fit: BoxFit.fitHeight,
                              height: 55,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color:
                                          Color.fromRGBO(24, 144, 255, 1.0))),
                              child: Image.asset(
                                "assets/images/mobile-logo.png",
                                fit: BoxFit.fitHeight,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: LettutorFontStyles.normalText,
                        ),
                        TextButton(
                          child: Text('Log in',
                              style: LettutorFontStyles.normalText.copyWith(
                                color: LettutorColors.lightBlueColor,
                              )),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginPage()));
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
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        constraints: const BoxConstraints(maxWidth: 350),
                        child: content),
                    Expanded(child: image),
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
