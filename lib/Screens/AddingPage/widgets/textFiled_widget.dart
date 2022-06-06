// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class MycustomTextfild extends StatelessWidget {
  String? hinttexts;
  final kay;
  final IconData? icon;
  final keyboddesble;
  final TextEdigcontroller;
  final maxlength;

  MycustomTextfild(
      {Key? key,
      this.hinttexts,
      this.icon,
      this.kay,
      required this.keyboddesble,
      this.TextEdigcontroller,
      this.maxlength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 4.h,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
              ],
              maxLength: maxlength,
              controller: TextEdigcontroller,
              enabled: keyboddesble,
              keyboardType: kay,
              decoration: InputDecoration(
                  disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 1)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black54,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, width: 1)),
                  prefixIcon: Icon(
                    icon,
                    color: const Color.fromARGB(255, 43, 164, 47),
                  ),
                  hintText: '$hinttexts'),
            ),
          ),
        ),
      ],
    );
  }
}
