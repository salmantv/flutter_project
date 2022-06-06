import 'package:flutter/material.dart';

import 'widgets/top_Section .dart';

class Adding extends StatelessWidget {
  const Adding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      scrollDirection: Axis.vertical,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Color(0xffdddddd)),
          child: const SafeArea(
            child: TopBackgroundcontainer(),
          )),
    ));
  }
}
