import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/pages/teachers/ListTeacherPage.dart';
import 'package:let_tutor/utils/components/common.dart';
import 'package:let_tutor/utils/components/teachers/RegisterTutorProgress.dart';

class LettutorPageApproval extends StatefulWidget {
  const LettutorPageApproval({Key? key}) : super(key: key);

  @override
  State<LettutorPageApproval> createState() => _LettutorPageApprovalState();
}

class _LettutorPageApprovalState extends State<LettutorPageApproval> {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 72,
                    width: 72,
                    child: SvgPicture.asset(
                      'assets/icons/smile.svg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Text('You have done all the steps'),
                  Text('Please, wait for the operator\'s approval'),
                  ElevatedButton(
                      onPressed: () {
                        PushTo(
                            context: context, destination: ListTeacherPage());
                      },
                      child: Text('Back Home'))
                ],
              )
            ],
          )),
    );
  }
}
