import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Model/Categroy_Model/catagroy_model.dart';
import '../../Model/Translation_model/translation_model.dart';
import '../../db_functions/Category_db/category_db.dart';
import '../../db_functions/Translation/translation_db.dart';
import '../../icons/myicons.dart';
import '../AddingPage/widgets/textFiled_widget.dart';
import '../Globlefunctions/globle.dart';
import '../home/widget/controllroom.dart';

// ignore: must_be_immutable
class Update extends StatefulWidget {
  // ignore: non_constant_identifier_names
  Update({Key? key, required this.Data}) : super(key: key);

  // ignore: non_constant_identifier_names
  TranclationModel? Data;

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  DateTime? selecteddate;
  final oldamount = TextEditingController();
  final oldcategory = TextEditingController();
  final oldnot = TextEditingController();
  final dateshowing = TextEditingController();
  final monthshwing = TextEditingController();

  @override
  void initState() {
    oldamount.text = widget.Data!.amount.toString();
    oldnot.text = widget.Data!.not.toString();
    oldcategory.text = widget.Data!.catagry.name.toString();
    dateshowing.text = widget.Data!.datetime.day.toString();
    monthshwing.text = monthnames[widget.Data!.datetime.month - 1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: const [],
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 250, 246, 246)),
      body: Container(
          width: 100.w,
          height: 80.h,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 250, 246, 246)),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                            return const Controll();
                          }), (route) => false);
                        },
                        icon: const Icon(
                          MyFlutterApp.cross,
                          size: 30,
                          color: Colors.black54,
                        )),
                    IconButton(
                        onPressed: () async {
                          await transltionsadding();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                            return const Controll();
                          }), (route) => false);
                        },
                        icon: const Icon(
                          MyFlutterApp.checkmark_cicle,
                          size: 30,
                          color: Colors.black54,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                width: 50.w,
                height: 60.h,
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Card(
                    elevation: 10,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 20),
                      child: ListView(
                        children: [
                          MycustomTextfild(
                            // TextEdigcontroller: thiscondroller,
                            TextEdigcontroller: oldamount,
                            hinttexts: 'Amount',
                            icon: Icons.attach_money_sharp,
                            kay: TextInputType.number,
                            keyboddesble: true,
                          ),
                          GestureDetector(
                              onTap: () {
                                bottomsheet(context);
                                setState(() {});
                              },
                              child: MycustomTextfild(
                                TextEdigcontroller: oldcategory,
                                icon: Icons.category,
                                keyboddesble: false,
                              )),
                          SizedBox(
                            height: 4.h,
                          ),
                          TextButton.icon(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: Color.fromARGB(255, 93, 93, 93),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                            ),
                            onPressed: () async {
                              await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now()
                                          .subtract(const Duration(days: 365)),
                                      lastDate: DateTime.now())
                                  .then((value) {
                                setState(() {
                                  dateshowing.text = value!.day.toString();
                                  monthshwing.text =
                                      monthnames[value.month - 1];
                                  selecteddate = value;
                                });
                              });
                            },
                            icon: const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(
                                MyFlutterApp.calendar,
                                color: Color.fromARGB(255, 43, 164, 47),
                              ),
                            ),
                            label: Row(
                              children: [
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  "${monthshwing.text} ${dateshowing.text}",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 84, 83, 83),
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          MycustomTextfild(
                            maxlength: 15,
                            TextEdigcontroller: oldnot,
                            hinttexts: 'Not',
                            icon: Icons.note_alt,
                            kay: TextInputType.name,
                            keyboddesble: true,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Future<void> transltionsadding() async {
    final _amoutparsed = double.parse(oldamount.text);

    final value = TranclationModel(
        catagry: selectedcategory ?? widget.Data!.catagry,
        amount: _amoutparsed,
        categorytyp: nowcategory ?? widget.Data!.categorytyp,
        datetime: selecteddate ?? widget.Data!.datetime,
        not: oldnot.text,
        id: widget.Data!.id.toString());

    Tracnsltion.instense.upadating(value);
  }

  Future bottomsheet(context) async {
    showModalBottomSheet(
        backgroundColor: const Color(0xff0097a7),
        elevation: 0,
        context: context,
        builder: (cotx) {
          return ValueListenableBuilder(
              valueListenable: widget.Data!.categorytyp == categorytype.income
                  ? Categoeydb.instense.IncomeCategory
                  : Categoeydb.instense.ExpanseCategory,
              builder: (BuildContext context, List<CategoryModel> newList, _) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 5 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5),
                    itemCount: newList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      final category = newList[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              oldcategory.text = category.name;
                              selectedcategory = category;
                            });
                            Navigator.of(cotx).pop();
                          },
                          child: Card(
                            elevation: 10,
                            color: const Color.fromARGB(255, 253, 253, 253),
                            child: ListTile(
                              title: Center(child: Text(category.name)),
                            ),
                          ),
                        ),
                      );
                    });
              });
        });
  }
}
