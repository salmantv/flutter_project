import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../Model/Categroy_Model/catagroy_model.dart';
import '../../../Model/Translation_model/translation_model.dart';
import '../../../db_functions/Translation/translation_db.dart';
import '../../../icons/moneyicons.dart';
import '../../../icons/myicons.dart';
import '../../AddingPage/main_adding_page.dart';
import '../../Globlefunctions/globle.dart';
import '../../upadating/updatingtrasction.dart';

class Tranclations extends StatefulWidget {
  const Tranclations({
    Key? key,
  }) : super(key: key);

  @override
  State<Tranclations> createState() => _TranclationsState();
}

class _TranclationsState extends State<Tranclations> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 10),
      child: ValueListenableBuilder(
          valueListenable: Tracnsltion.instense.transltionsnotfier,
          builder: (BuildContext context, List<TranclationModel> thislist, _) {
            return Tracnsltion.instense.transltionsnotfier.value.isEmpty
                ? InkWell(
                    onTap: () async {
                      selectedcategory = null;
                      categoryshow.text = '';
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (contex) {
                        return const Adding();
                      }));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/undraw_Note_list_re_r4u9.png",
                          height: 22.5.h,
                        ),
                        const Text(
                          "No transaction now trying to add",
                          style: TextStyle(color: Colors.black45, fontSize: 14),
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 20,
                    ),
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        final newList = thislist.reversed;
                        final values = newList.elementAt(index);
                        return Column(children: [
                          GestureDetector(
                            onLongPress: () async {
                              await controlloptions(context, values);
                            },
                            child: ListTile(
                              // onTap: () {},
                              leading: values.categorytyp == categorytype.income
                                  ? const Icon(
                                      Money.finance,
                                      size: 30,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Money.hand_money_rupee_coin,
                                      color: Colors.red,
                                      size: 28,
                                    ),
                              title: AutoSizeText(
                                values.catagry.name.toUpperCase(),
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 14.5,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: AutoSizeText(
                                values.not,
                                style: const TextStyle(
                                    fontSize: 12.5,
                                    color: Colors.black54,
                                    fontFamily: "HKGrotesk"),
                              ),
                              trailing: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AutoSizeText(
                                    values.categorytyp == categorytype.income
                                        ? "   +${values.amount}"
                                        : "   -${values.amount}",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: values.categorytyp ==
                                                categorytype.income
                                            ? const Color.fromARGB(
                                                255, 0, 111, 4)
                                            : Colors.red,
                                        fontFamily: "HKGrotesk-Bold"),
                                  ),
                                  AutoSizeText(
                                    " ${monthnames[values.datetime.month - 1]} ${values.datetime.day} ",
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]);
                      },
                      itemCount: thislist.length < 5 ? thislist.length : 5,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 1,
                          width: 0,
                        );
                      },
                    ),
                  );
          }),
    );
  }

  Future controlloptions(contescx, value) async {
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
                            Navigator.of(context).pop();
                            askingDeleting(contescx, value);
                          },
                          icon: const Icon(MyFlutterApp.trash_1)),
                      IconButton(
                          onPressed: () {
                            nowcategory = null;
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (ctx) {
                              return Update(Data: value);
                            }), (route) => false);
                          },
                          icon: const Icon(MyFlutterApp.pencil_1)),
                    ],
                  )
                ],
              ));
        });
  }

  Future askingDeleting(contescx, TranclationModel value) async {
    showDialog(
        context: contescx,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Category deleting"),
            content: SizedBox(
              height: 12.h,
              child: Column(
                children: [
                  const Text(
                    "Are you sure you want to delete the record ?",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
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
                    Navigator.of(context).pop();
                    setState(() {});
                    addedsnackbar();
                  },
                  child: const Text("ok"))
            ],
          );
        });
  }

  addedsnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 208, 86, 77),
        content: Text(" You deleted the Transactions  ")));
  }
}
