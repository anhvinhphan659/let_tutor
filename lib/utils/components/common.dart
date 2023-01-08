import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/pages/account/SettingPage.dart';

// AppBar LettutorAppbar({bool isSignedIn = false}) {
//   return AppBar(
//     backgroundColor: Colors.white,
//     leading: Container(
//       height: 39,
//       child: SvgPicture.asset(
//         'assets/images/lettutor_logo.svg',
//         fit: BoxFit.fitWidth,
//       ),
//     ),
//     leadingWidth: 300,
//     actions: [
//       PopupMenuButton<int>(
//           offset: Offset(0, 60),
//           icon: Container(
//             width: 38,
//             height: 38,
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Color.fromRGBO(228, 230, 235, 1.0),
//               // borderRadius: BorderRadius.circular(50)),
//               shape: BoxShape.circle,
//             ),
//             child: SvgPicture.network(
//               'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/us.svg',
//               fit: BoxFit.fitWidth,
//             ),
//           ),
//           itemBuilder: (context) {
//             return [
//               PopupMenuItem<int>(
//                 value: 1,
//                 child: Row(children: [
//                   SizedBox(
//                     width: 22,
//                     height: 22,
//                     child: SvgPicture.network(
//                       'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/us.svg',
//                       fit: BoxFit.fitHeight,
//                     ),
//                   ),
//                   Text('English')
//                 ]),
//               ),
//               PopupMenuItem<int>(
//                 child: Row(children: [
//                   SizedBox(
//                     width: 22,
//                     height: 22,
//                     child: SvgPicture.network(
//                       'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/vn.svg',
//                       fit: BoxFit.fitHeight,
//                     ),
//                   ),
//                   Text('Vietnamese')
//                 ]),
//                 value: 2,
//               ),
//             ];
//           }),
//       // IconButton(
//       //   onPressed: () {
//       //     PushTo(context: context, destination: SettingPage());
//       //   },
//       //   icon: Icon(
//       //     Icons.menu,
//       //     color: Colors.black,
//       //   ),
//       // )
//     ],
//   );
// }

class LettutorAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isLogin;
  const LettutorAppBar(
      {Key? key,
      this.isLogin = true,
      this.preferredSize = const Size.fromHeight(kToolbarHeight)})
      : super(key: key);

  @override
  State<LettutorAppBar> createState() => _LettutorAppBarState();

  @override
  final Size preferredSize;
}

class _LettutorAppBarState extends State<LettutorAppBar> {
  var imgURL =
      'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/us.svg';
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            icon: Container(
              width: 38,
              height: 38,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(228, 230, 235, 1.0),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.network(
                imgURL,
                fit: BoxFit.fitWidth,
              ),
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  onTap: () {
                    setState(() {
                      imgURL =
                          'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/us.svg';
                    });
                  },
                  value: 1,
                  child: Row(children: [
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: SvgPicture.network(
                        'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/us.svg',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Text('English')
                  ]),
                ),
                PopupMenuItem<int>(
                  onTap: () {
                    setState(() {
                      imgURL =
                          'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/vn.svg';
                    });
                  },
                  value: 2,
                  child: Row(children: [
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: SvgPicture.network(
                        'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/vn.svg',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Text('Vietnamese')
                  ]),
                ),
              ];
            }),
        widget.isLogin
            ? GestureDetector(
                onTap: () {
                  PushTo(context: context, destination: SettingPage());
                },
                child: Container(
                  width: 38,
                  height: 38,
                  padding: EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(228, 230, 235, 1.0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.list,
                    color: Color.fromRGBO(100, 100, 100, 1.0),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

// AppBar LoginAppBar(BuildContext context) => AppBar(
//       backgroundColor: Colors.white,
//       leading: Container(
//         height: 39,
//         child: SvgPicture.asset(
//           'assets/images/lettutor_logo.svg',
//           fit: BoxFit.fitWidth,
//         ),
//       ),
//       leadingWidth: 300,
//       actions: [
//         PopupMenuButton<int>(
//             offset: Offset(0, 60),
//             icon: Container(
//               width: 38,
//               height: 38,
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Color.fromRGBO(228, 230, 235, 1.0),
//                 // borderRadius: BorderRadius.circular(50)),
//                 shape: BoxShape.circle,
//               ),
//               child: SvgPicture.network(
//                 'https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/us.svg',
//                 fit: BoxFit.fitWidth,
//               ),
//             ),
//             itemBuilder: (context) {
//               return [
//                 PopupMenuItem<int>(
//                   child: Text('Option 1'),
//                   value: 1,
//                 ),
//                 PopupMenuItem<int>(
//                   child: Text('Option 2'),
//                   value: 2,
//                 ),
//                 PopupMenuItem<int>(
//                   child: Text('Option 3'),
//                   value: 3,
//                 ),
//               ];
//             }),
//         IconButton(
//           onPressed: () {
//             PushTo(context: context, destination: SettingPage());
//           },
//           icon: const Icon(
//             Icons.list,
//             color: Color.fromRGBO(100, 100, 100, 1.0),
//           ),
//         )
//       ],
//     );

Widget LettutorContainer({
  required Widget body,
  bool isLogin = true,
}) {
  return Scaffold(
    appBar: LettutorAppBar(
      isLogin: isLogin,
    ),
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
