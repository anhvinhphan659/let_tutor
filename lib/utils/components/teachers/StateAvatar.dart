import 'dart:math';

import 'package:flutter/material.dart';

class StateAvatar extends StatelessWidget {
  final double backgroundRadius;
  final double foregroundRadius;
  Widget? child;
  Widget? topWidget;
  final bool displayTop;
  final double dx;

  StateAvatar(
      {required this.backgroundRadius,
      this.child,
      this.topWidget,
      this.foregroundRadius = 5,
      this.displayTop = false,
      this.dx = 0,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double dx = backgroundRadius * (1 + sqrt(2) / 2);

    return Stack(
      children: [
        ClipOval(
          child: Container(
            height: backgroundRadius * 2,
            width: backgroundRadius * 2,
            color: Colors.white,
            child: Center(child: child),
          ),
        ),
        displayTop
            ? Positioned(
                top: dx,
                left: dx,
                child: CircleAvatar(
                  radius: foregroundRadius,
                  backgroundColor: Colors.green,
                  child: topWidget,
                ))
            : const SizedBox(),
      ],
    );
  }
}
