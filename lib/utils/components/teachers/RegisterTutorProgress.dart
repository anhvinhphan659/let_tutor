import 'package:flutter/material.dart';
import 'package:let_tutor/utils/styles/styles.dart';

class RegisterTutorProgress extends StatelessWidget {
  final List<String> steps;
  final int progress;

  const RegisterTutorProgress(
      {required this.steps, required this.progress, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    List<Widget> widgets = List.generate(
        steps.length,
        (index) => StepComponent(
            th: index,
            step: steps[index],
            isCurrent: index <= progress,
            isDone: index < progress));
    return Container(
      child: screenWidth < 400
          ? Column(
              children: widgets,
            )
          : Row(
              children: widgets,
            ),
    );
  }

  Widget StepComponent(
      {int th = 0,
      String step = '',
      bool isCurrent = false,
      bool isDone = false}) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
              color: isCurrent ? LettutorColors.blueColor : Colors.transparent,
              borderRadius: BorderRadius.circular(32),
              border: isCurrent == false
                  ? Border.all(color: Color.fromRGBO(0, 0, 0, 0.25))
                  : Border.all(color: LettutorColors.blueColor)),
          child: Center(
            child: isDone
                ? Icon(Icons.check)
                : Text(
                    th.toString(),
                  ),
          ),
        ),
        Text(step),
      ],
    );
  }
}
