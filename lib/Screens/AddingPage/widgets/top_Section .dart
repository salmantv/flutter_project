// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'Radio_buttone_widget.dart';
import 'adding_widget.dart';

class TopBackgroundcontainer extends StatelessWidget {
  const TopBackgroundcontainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 50.h,
            decoration: const BoxDecoration(
                color: Color(0xff0097a7),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 10.0,
                  ),
                ]),
            child: const Topsection()),
        const Detailsadding(),
      ],
    );
  }
}
