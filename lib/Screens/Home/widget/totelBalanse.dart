// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../Model/Translation_model/translation_model.dart';
import '../../../db_functions/Translation/translation_db.dart';
import '../../Globlefunctions/globle.dart';
import 'package:auto_size_text/auto_size_text.dart';

// ignore: must_be_immutable
class Total extends StatefulWidget {
  // ignore: non_constant_identifier_names
  Total({Key? key, this.heding, this.monthe, this.amount}) : super(key: key);

  String? heding;
  String? monthe;
  double? amount;

  @override
  State<Total> createState() => _TotalState();
}

class _TotalState extends State<Total> {
  @override
  void initState() {
    math(Tracnsltion.instense.transltionsnotfier.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
          width: 80.w,
          height: 28.6.h,
          child: ValueListenableBuilder(
              valueListenable: Tracnsltion.instense.transltionsnotfier,
              builder:
                  (BuildContext context, List<TranclationModel> newlist, _) {
                math(Tracnsltion.instense.transltionsnotfier.value);
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  elevation: 20,
                  color: const Color(0xff0097a7),
                  margin: const EdgeInsets.only(top: 45, left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.heding}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      AutoSizeText(
                        widget.amount! > 0 ? "₹ ${widget.amount}" : "0.00",
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        " ${widget.monthe}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
