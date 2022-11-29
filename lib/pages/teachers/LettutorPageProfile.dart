import 'package:flutter/material.dart';
import 'package:let_tutor/pages/teachers/LettutorPageIntroduction.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/RegisterTutorProgress.dart';
import 'package:let_tutor/utils/components/teachers/SkillTag.dart';

class LettutorPageProfile extends StatefulWidget {
  const LettutorPageProfile({Key? key}) : super(key: key);

  @override
  State<LettutorPageProfile> createState() => _LettutorPageProfileState();
}

class _LettutorPageProfileState extends State<LettutorPageProfile> {
  final List<String> stepList = [
    'Complete profile',
    'Video introduction',
    'Approval'
  ];

  var levelOptions = ["Beginner", "Intermediate", "Advanced"];
  int selectedLevel = -1;

  var skillSelected = {for (var s in skillTags.keys) s: false};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LettutorAppBar(),
      body: Container(
        color: Colors.white,
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const RegisterTutorProgress(
                steps: ['Complete profile', 'Video introduction', 'Approval'],
                progress: 0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Image.asset(
                    'assets/images/intro_image.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Expanded(
                  // width: 200,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Set up your tutor profile'),
                        Text(
                          'Your tutor profile is your chance to market yourself to students on Tutoring. You can make edits later on your profile settings page.',
                          maxLines: 4,
                        ),
                        Text(
                          'New students may browse tutor profiles to find a tutor that fits their learning goals and personality. Returning students may use the tutor profiles to find tutors they\'ve had great experiences with already.',
                          maxLines: 6,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            FlowHeader("Basic info"),
            Row(
              children: [
                Container(
                  width: 222,
                  height: 222,
                  color: Color.fromRGBO(221, 221, 221, 1.0),
                  child: Center(child: Text('Upload avatar here...')),
                ),
              ],
            ),
            Text('Click to  edit'),
            InformationPanel(
                'Please upload a professional photo. See guidelines'),
            Text('Tutoring name'),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            Text('I\'m from'),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            Text('Date of Birth'),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            FlowHeader('CV'),
            Text(
              'Students will view this information on your profile to decide if you\'re a good fit for them.',
              maxLines: 3,
            ),
            InformationPanel(
                'In order to protect your privacy, please do not share your personal information (email, phone number, social email, skype, etc) in your profile.'),
            Text('Interests'),
            TextField(
              maxLines: 8, //or null
              decoration: InputDecoration.collapsed(
                  border: OutlineInputBorder(),
                  hintText:
                      "Interests, hobbies, memorable life experiences, or anything else you'd like to share!"),
            ),
            Text('Education'),
            TextField(
              maxLines: 8, //or null
              decoration: InputDecoration.collapsed(
                  border: OutlineInputBorder(),
                  hintText:
                      "Example: \"Bachelor of Arts in English from Cambly University; Certified yoga instructor, Second Language Acquisition and Teaching  (SLAT) certificate from Cambly University\""),
            ),
            Text('Experience'),
            TextField(
              maxLines: 8, //or null
              decoration: InputDecoration.collapsed(
                  border: OutlineInputBorder(), hintText: ""),
            ),
            Text('Current or Previous Profession'),
            TextField(
              maxLines: 8, //or null
              decoration: InputDecoration.collapsed(
                  border: OutlineInputBorder(), hintText: ""),
            ),
            Text('Certificate'),
            Table(
              children: [
                TableRow(children: [
                  Container(
                    child: Text('Certicate Type'),
                    color: Color.fromRGBO(250, 250, 250, 1.0),
                  ),
                  Container(
                    child: Text('Certicate'),
                    color: Color.fromRGBO(250, 250, 250, 1.0),
                  ),
                  Container(
                    child: Text('Action'),
                    color: Color.fromRGBO(250, 250, 250, 1.0),
                  ),
                ]),
                TableRow(children: [
                  Text(''),
                  Text(''),
                  Text(''),
                ])
              ],
            ),
            FlowHeader('Languages I speak'),
            Text('Languages'),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            FlowHeader('Who I teach'),
            InformationPanel(
                'This is the first thing students will see when looking for tutors.'),
            Text('Introduction'),
            TextField(
              maxLines: 8, //or null
              decoration: InputDecoration.collapsed(
                  border: OutlineInputBorder(),
                  hintText:
                      "Example: \"I was a doctor for 35 years and can help you practice business or medical English. I also enjoy teaching beginners as I am very patient and always speak slowly and clearly. \""),
            ),
            Text('I am best at teaching students who are'),
            Wrap(
              children: List.generate(
                  levelOptions.length,
                  (index) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<int>(
                            value: index,
                            onChanged: (value) {
                              setState(() {
                                selectedLevel = value!;
                              });
                            },
                            groupValue: selectedLevel,
                          ),
                          Text(levelOptions[index])
                        ],
                      )),
            ),
            Text('My specialties are'),
            ...skillSelected.keys.toList().map(
                  (e) => Row(
                    children: [
                      Checkbox(
                          value: skillSelected[e],
                          onChanged: (value) {
                            setState(() {
                              skillSelected[e] = value!;
                            });
                          }),
                      Text(e)
                    ],
                  ),
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      PushTo(
                          context: context,
                          destination: LettutorPageIntroduction());
                    },
                    child: Text('Next'))
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget FlowHeader(String header) {
  return Stack(
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 2,
            color: Color.fromRGBO(0, 0, 0, 0.06),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(header),
          ),
        ],
      )
    ],
  );
}

Widget InformationPanel(String message) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    color: Color.fromRGBO(230, 247, 255, 1.0),
    child: Text(
      message,
      maxLines: 5,
    ),
  );
}
