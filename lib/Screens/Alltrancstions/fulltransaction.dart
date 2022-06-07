import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Model/Translation_model/translation_model.dart';
import '../../db_functions/Translation/translation_db.dart';
import '../../icons/moneyicons.dart';
import '../../icons/myicons.dart';
import '../AddingPage/main_adding_page.dart';
import '../Globlefunctions/globle.dart';
import '../../Model/Categroy_Model/catagroy_model.dart';
import '../upadating/updatingtrasction.dart';

class Datesbuliding extends StatefulWidget {
  Datesbuliding({Key? key, this.name, this.value}) : super(key: key);

  late final name;
  late final value;

  @override
  State<Datesbuliding> createState() => _DatesbulidingState();
}

class _DatesbulidingState extends State<Datesbuliding> {
  @override
  Widget build(BuildContext context) {
    return Tracnsltion.instense.transltionsnotfier.value.isEmpty
        ? InkWell(
            onTap: () async {
              selectedcategory = null;
              categoryshow.text = '';
              Navigator.of(context).push(MaterialPageRoute(builder: (contex) {
                return const Adding();
              }));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/emptydata.png",
                  height: 22.5.h,
                ),
                const Text(
                  "No transaction now trying to add",
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                )
              ],
            ),
          )
        : SizedBox(
            child: ValueListenableBuilder(
                valueListenable: dropselectedvalus == "1"
                    ? Tracnsltion.instense.transltionsnotfier
                    : dropselectedvalus == "2"
                        ? Tracnsltion.instense.todaynotfier
                        : dropselectedvalus == "3"
                            ? Tracnsltion.instense.yesterdaynotfier
                            : dropselectedvalus == '4'
                                ? Tracnsltion.instense.monthnotfier
                                : dropselectedvalus == '5'
                                    ? Tracnsltion.instense.incomenotfiere
                                    : dropselectedvalus == '6'
                                        ? Tracnsltion.instense.expansenotfiere
                                        : Tracnsltion
                                            .instense.transltionsnotfier,
                builder:
                    (BuildContext context, List<TranclationModel> newlist, _) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: newlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      final valurs = newlist[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 8),
                        child: GestureDetector(
                          onLongPress: () async {
                            dropselectedvalus == '4'
                                ? const SizedBox()
                                : await controlloptions(context, valurs);
                          },
                          child: Card(
                              elevation: 5,
                              color: Colors.white,
                              child: ListTile(
                                leading: valurs.categorytyp ==
                                        categorytype.expanse
                                    ? const Icon(
                                        Money.hand_money_rupee_coin,
                                        color: Color.fromARGB(255, 181, 6, 6),
                                        size: 30,
                                      )
                                    : const Icon(
                                        Money.finance,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                title: Text(
                                  valurs.catagry.name,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 30, 29, 29),
                                      fontFamily: "HKGrotesk-Bold"),
                                ),
                                subtitle: Text(
                                  valurs.not,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontFamily: "HKGrotesk"),
                                ),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      valurs.categorytyp == categorytype.income
                                          ? '+' " ${valurs.amount}"
                                          : '-'
                                              " ${valurs.amount}",
                                      style: TextStyle(
                                          color: valurs.categorytyp ==
                                                  categorytype.income
                                              ? const Color.fromARGB(
                                                  255, 1, 255, 9)
                                              : Colors.red,
                                          fontFamily: "HKGrotesk-Bold"),
                                    ),
                                    Text(
                                      " ${monthnames[valurs.datetime.month - 1]} ${valurs.datetime.day} ",
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 23, 23)),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                  );
                }),
          );
  }

  Future controlloptions(context, value) async {
    showModalBottomSheet(
        elevation: 0,
        context: context,
        builder: (cotx) {
          return SizedBox(
              height: 9.h,
              width: 20.w,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(MyFlutterApp.cross),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(cotx).pop();

                            askingDeleting(context, value);
                          },
                          icon: const Icon(MyFlutterApp.trash_1)),
                      IconButton(
                          onPressed: () {
                            nowcategory = null;
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (contex) {
                              return Update(Data: value);
                            }));
                          },
                          icon: const Icon(MyFlutterApp.pencil_1)),
                    ],
                  )
                ],
              ));
        });
  }

  Future askingDeleting(contescx, value) async {
    showDialog(
        context: contescx,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Category Deleting"),
            content: SizedBox(
              height: 9.h,
              child: Column(
                children: const [
                  Text(
                    "Are you sure you want to delete the record ? ",
                    style: TextStyle(fontSize: 15),
                  ),
                  // SizedBox(
                  //   height: 60.h,
                  // ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Tracnsltion.instense.deleteingTrastions(value);
                    Navigator.of(ctx).pop();

                    addedsnackbar();
                    setState(() {});
                  },
                  child: const Text("ok"))
            ],
          );
        });
  }

  addedsnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Color.fromARGB(255, 208, 86, 77),
        content: Text(" You deleted the Transactions  ")));
  }
}
