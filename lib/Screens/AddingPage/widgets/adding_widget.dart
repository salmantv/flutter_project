// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable, file_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../Model/Categroy_Model/catagroy_model.dart';
import '../../../Model/Translation_model/translation_model.dart';
import '../../../db_functions/Category_db/category_db.dart';
import '../../../db_functions/Translation/translation_db.dart';
import '../../../icons/myicons.dart';
import '../../Category/category_mainpage.dart';
import '../../Home/widget/controllroom.dart';
import 'textFiled_widget.dart';
import '../../Globlefunctions/globle.dart';

// ignore: must_be_immutable
class Detailsadding extends StatefulWidget {
  const Detailsadding({Key? key}) : super(key: key);

  @override
  State<Detailsadding> createState() => _DetailsaddingState();
}

class _DetailsaddingState extends State<Detailsadding> {
  final amountcondroller = TextEditingController();
  final notescondroller = TextEditingController();
  final categorycondroller = TextEditingController();
  DateTime? selecteddate;
  final dateshowing = TextEditingController();
  final monthshwing = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final amoutparsed;

  @override
  void initState() {
    super.initState();
    dateshowing.text = DateTime.now().day.toString();
    monthshwing.text = monthnames[DateTime.now().month - 1];
    selecteddate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 22.5.h,
      left: 20,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          width: 88.5.w,
          height: 60.5.h,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 40.0)
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 3.6.h,
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    validator: ((value) {
                      if (value!.isEmpty || value == null) {
                        return 'Amount is empty';
                      }
                      return null;
                    }),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                    ],
                    controller: amountcondroller,
                    enabled: true,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black54, width: 1)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black87,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black54, width: 1)),
                        prefixIcon: Icon(
                          MyFlutterApp.money,
                          color: Color.fromARGB(255, 43, 164, 47),
                        ),
                        hintText: 'Amount'),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {});
                      bottomsheet(context);
                    },
                    child: MycustomTextfild(
                      TextEdigcontroller: categoryshow,
                      hinttexts: "Category",
                      icon: MyFlutterApp.pie_chart,
                      keyboddesble: false,
                    )),
                SizedBox(
                  height: 4.h,
                ),
                TextButton.icon(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color.fromARGB(255, 93, 93, 93),
                        ),
                        borderRadius: BorderRadius.circular(5.0))),
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
                        monthshwing.text = monthnames[value.month - 1];
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
                  maxlength: 16,
                  TextEdigcontroller: notescondroller,
                  hinttexts: "Add some notes",
                  icon: MyFlutterApp.note,
                  kay: TextInputType.name,
                  keyboddesble: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xff0097a7),
                        ),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                left: 60, right: 60, top: 15, bottom: 15))),
                    onPressed: () async {
                      formKey.currentState!.validate();
                      await transltionsadding();
                      selecteddate == null || selectedcategory == null
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  duration: Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text("Something wrong")))
                          : Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                              return const Controll();
                            }), (route) => false);
                      chartdrop = 'transltionsnotfier';
                      setState(() {});
                    },
                    child: const Text("Add")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> transltionsadding() async {
    double amoutparsed = double.tryParse(amountcondroller.text) ?? 0;

    if (selectedcategory == null) {
      return;
    }

    if (selecteddate == null) {
      return;
    }

    if (amoutparsed == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text("You forgot to add amount")));
    }

    final value = TranclationModel(
        catagry: selectedcategory!,
        amount: amoutparsed,
        categorytyp: nowcategory!,
        datetime: selecteddate!,
        not: notescondroller.text == "" ? 'Note : empty' : notescondroller.text,
        id: DateTime.now().microsecondsSinceEpoch.toString());
    Tracnsltion.instense.addtransltion(value);
  }

  Future bottomsheet(context) async {
    showModalBottomSheet(
        elevation: 0,
        context: context,
        builder: (cotx) {
          return Container(
            height: 40.h,
            decoration: const BoxDecoration(
              color: Color(0xff0097a7),
            ),
            child: nowcategory == categorytype.income &&
                    Categoeydb.instense.IncomeCategory.value.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        width: 32.h,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return const Category_Page();
                              }));
                            },
                            child: const Text(
                              "Sorry ! we can found any Category here ,"
                              " Now you can add category ,\nif you want add click here and create category ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )),
                      ),
                      Center(
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.white,
                            )),
                      )
                    ],
                  )
                : nowcategory == categorytype.expanse &&
                        Categoeydb.instense.ExpanseCategory.value.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 7.h,
                          ),
                          SizedBox(
                            width: 32.h,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return const Category_Page();
                                  }));
                                },
                                child: const Text(
                                  "Sorry ! we can found any Category here ,"
                                  " Now you can add category ,\nif you want add click here and create category ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                )),
                          ),
                          Center(
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      )
                    : ValueListenableBuilder(
                        valueListenable: checking(),
                        builder: (BuildContext context,
                            List<CategoryModel> newList, _) {
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
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      categoryshow.text =
                                          category.name.toString();
                                      selectedcategory = category;
                                      Navigator.of(cotx).pop();
                                      setState(() {});
                                    },
                                    child: Card(
                                      elevation: 10,
                                      color: const Color.fromARGB(
                                          255, 253, 253, 253),
                                      child: ListTile(
                                        title: Text(category.name),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }),
          );
        });
  }

  checking() {
    if (nowcategory == categorytype.income) {
      Categoeydb.instense.IncomeCategory;
      // selectedcategory = null;
      return Categoeydb.instense.IncomeCategory;
    } else {
      Categoeydb.instense.ExpanseCategory;
      return Categoeydb.instense.ExpanseCategory;
    }
  }
}
