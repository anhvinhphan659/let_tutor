import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar LettutorAppbar() {
  return AppBar(
    backgroundColor: Colors.white,
    title: Container(
      height: 39,
      child: SvgPicture.network(
        'https://sandbox.app.lettutor.com/static/media/lettutor_logo.91f91ade.svg',
        fit: BoxFit.fitHeight,
      ),
    ),
    actions: [],
  );
}
