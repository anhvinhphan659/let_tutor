import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/pages/account/SettingPage.dart';

AppBar LettutorAppbar({bool isSignedIn = false}) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: false,
    leading: Container(
      child: SvgPicture.asset(
        'assets/images/lettutor_logo.svg',
        fit: BoxFit.fitWidth,
      ),
    ),
    leadingWidth: 300,
    actions: [
      IconButton(
          onPressed: () {
            // Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.confirmation_num_rounded,
          ))
    ],
  );
}

AppBar LoginAppBar(BuildContext context) => AppBar(
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
    );

Widget LettutorContainer({
  required Widget body,
}) {
  return Scaffold(
    appBar: LettutorAppbar(),
    endDrawer: Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          Scaffold.of(context).openEndDrawer();
        },
        child: Drawer(
          child: ListView(children: [Text("Item 1")]),
        ),
      ),
    ),
    body: body,
    resizeToAvoidBottomInset: false,
  );
}

void PushTo({required BuildContext context, required Widget destination}) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => destination));
}

void BackToPrevious({required BuildContext context}) {
  Navigator.of(context).pop();
}
