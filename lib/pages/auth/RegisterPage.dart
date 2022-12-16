import 'package:flutter/material.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/pages/auth/LoginPage.dart';
import 'package:let_tutor/utils/styles/styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                        Text('PASSWORD', style: LettutorFontStyles.formLabel),
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: LettutorColors.primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0))),
                    child: TextButton(
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          "SIGN UP",
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
