import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/StateAvatar.dart';
import 'package:let_tutor/utils/styles/styles.dart';

import 'SettingPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final levelOptions = [
    "Pre A1 (Beginner)",
    "A1 (Higher Beginner)",
    "A2 (Pre-Intermediate)",
    "B1 (Intermediate)",
    "B2 (Upper-Intermediate)",
    "C1 (Advanced)",
    "C2 (Proficiency)",
  ];
  var expandTab = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Container(
        color: Colors.white,
        child: ListView(children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: StateAvatar(
                          backgroundRadius: 130,
                          foregroundRadius: 20,
                          child: Container(color: Colors.red),
                          dx: 200,
                          topWidget: Icon(
                            Icons.pending,
                            size: 20,
                          ),
                          displayTop: true,
                        ),
                      ),
                      Text('Avatar'),
                      Text(
                        'Account ID: a168dca7-1cb1-4dc8-80c3-57001b83ddfb',
                        maxLines: 2,
                      ),
                      TextButton(
                          onPressed: () {}, child: Text('Others review you'))
                    ],
                  ),
                ),
                ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: Text('Account'),
                  children: [
                    Text('Name'),
                    TextField(),
                    Text('Email Address'),
                    TextField(
                      enabled: false,
                    ),
                    Text('Country'),
                    TextField(),
                    Text('Phone number'),
                    TextField(
                      enabled: false,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(246, 255, 237, 1.0),
                        border: Border.all(
                            color: Color.fromRGBO(183, 235, 143, 1.0)),
                      ),
                      child: Text(
                        'Verify',
                        style: LettutorFontStyles.descriptionText.copyWith(
                          color: Color.fromRGBO(56, 158, 13, 1.0),
                        ),
                      ),
                    ),
                    Text('My Level'),
                    DropdownButton(items: [
                      ...levelOptions.map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      ),
                    ], onChanged: (value) => print(value)),
                    Text('Want to learn'),
                    TextField(
                      enabled: false,
                    ),
                    Text('Study Schedule'),
                    GFMultiSelect(
                        items: [],
                        onSelect: (value) {
                          print(value);
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {}, child: Text('Save changes')),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
