import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/pages/teachers/LettutorPageApproval.dart';
import 'package:let_tutor/pages/teachers/LettutorPageProfile.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/RegisterTutorProgress.dart';

class LettutorPageIntroduction extends StatefulWidget {
  const LettutorPageIntroduction({Key? key}) : super(key: key);

  @override
  State<LettutorPageIntroduction> createState() =>
      _LettutorPageIntroductionState();
}

class _LettutorPageIntroductionState extends State<LettutorPageIntroduction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LettutorAppBar(),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            const RegisterTutorProgress(
                steps: ['Complete profile', 'Video introduction', 'Approval'],
                progress: 1),
            Row(
              children: [
                SizedBox(
                  width: 120,
                  // height: 120,
                  child: SvgPicture.asset(
                    'assets/images/tutor_video.svg',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Introduce yourself'),
                      Text(
                        'Let students know what they can expect from a lesson with you by recording a video highlighting your teaching style, expertise and personality. Students can be nervous to speak with a foreigner, so it really helps to have a friendly video that introduces yourself and invites students to call you.',
                        maxLines: 8,
                      )
                    ],
                  ),
                ),
              ],
            ),
            FlowHeader('Introduction video'),
            InformationPanel(
              '''
              A few helpful tips:

                1.Find a clean and quiet space
                2.Smile and look at the camera
                3.Dress smart
                4.Speak for 1-3 minutes
                5.Brand yourself and have fun!
              ''',
            ),
            Center(
              child: ElevatedButton(
                child: Text('Choose video'),
                onPressed: () {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: Text('Previous'),
                  onPressed: () {
                    PushTo(
                        context: context,
                        destination: LettutorPageIntroduction());
                  },
                ),
                ElevatedButton(
                  child: Text('Next'),
                  onPressed: () {
                    PushTo(
                        context: context, destination: LettutorPageApproval());
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
