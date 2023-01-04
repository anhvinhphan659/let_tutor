import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:let_tutor/handler/auth/auth_controller.dart';
import 'package:let_tutor/handler/data_handler.dart';
import 'package:let_tutor/handler/user/user_controller.dart';
import 'package:let_tutor/utils/components/common.dart';

import 'package:let_tutor/pages/auth/ForgotPasswordPage.dart';
import 'package:let_tutor/pages/auth/RegisterPage.dart';
import 'package:let_tutor/pages/teachers/ListTeacherPage.dart';
import 'package:let_tutor/utils/data/util_storage.dart';
import 'package:let_tutor/utils/styles/styles.dart';

import '../../utils/util_function.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSeen = false;
  final TextEditingController _usernameTxtController = TextEditingController();
  final TextEditingController _passwordTxtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const LettutorAppBar(isLogin: false),
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
                      "Say hello to your English tutors",
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
                        errorMaxLines: 3,
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
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSeen = !isSeen;
                              });
                            },
                            child: Icon(isSeen
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        errorMaxLines: 3,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      controller: _passwordTxtController,
                      obscureText: !isSeen,
                      autocorrect: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please input your Password!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextButton(
                      child: Text('Forgot Password?',
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
                        String email = _usernameTxtController.text;
                        String password = _passwordTxtController.text;

                        if (password.isEmpty || isValidEmail(email) != null) {
                          return;
                        }
                        var loginStatus =
                            await AuthController.login(email, password);

                        if (loginStatus == LOGIN_STATUS.SUCCESSFUL) {
                          //handle login success
                          DataHandler.setData("Email", email);
                          DataHandler.setData("Password", password);
                          UserController.getUserInformation();
                          FirebaseAnalytics.instance
                              .logEvent(name: "login", parameters: {
                            "email": email,
                          }).then((value) {
                            print("Log event Sign in");
                          });
                          PushTo(
                              context: context,
                              destination: const ListTeacherPage());
                        }
                      },
                      child: Center(
                        child: Text(
                          "LOG IN",
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
                                print("Go to list teacher page");

                                PushTo(
                                    context: context,
                                    destination: ListTeacherPage());
                              }
                            },
                            icon: SvgPicture.asset(
                              "assets/icons/google-logo.svg",
                              fit: BoxFit.fitHeight,
                              height: 60,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "assets/icons/mobile-logo.svg",
                              fit: BoxFit.fitHeight,
                              height: 60,
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
                          'Not a member yet?',
                          style: LettutorFontStyles.normalText,
                        ),
                        TextButton(
                          child: Text('Sign up',
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

Future<bool> googleSignInHandle() async {
  var account = await GoogleSignIn().signIn();

  if (account != null) {
    print(account.email);
    var authenticate = await account.authentication;
    print("Google auth");
    print(authenticate.idToken);

    if (authenticate.accessToken != null) {
      print(authenticate.accessToken);
      var loginStatus =
          await AuthController.googleSignIn(authenticate.accessToken!);
      print(loginStatus);
      if (loginStatus == LOGIN_STATUS.SUCCESSFUL) {
        print("Login google success");
        DataHandler.setData("googleLoginEmail", account.email);
        FirebaseAnalytics.instance.logEvent(name: "login", parameters: {
          "email": account.email,
        }).then((value) {
          print("Log event Sign in");
        });

        return true;
      }
    } else {
      await GoogleSignIn().signOut();
    }
  }

  return false;
}

Future<void> facebookSignInHandle() async {
  var result =
      await FacebookAuth.i.login(permissions: ["public_profile", "email"]);
  if (result.status == LoginStatus.success) {
    print("Facebook Auth: ");
    print(result.accessToken);
  }
}
