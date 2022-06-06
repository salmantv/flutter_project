// ignore: file_names
// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../Model/Categroy_Model/catagroy_model.dart';
import '../../../db_functions/Category_db/category_db.dart';
import '../../../icons/myicons.dart';
import '../../AddingPage/widgets/textFiled_widget.dart';

class Incomecategoy extends StatefulWidget {
  const Incomecategoy({Key? key}) : super(key: key);

  @override
  State<Incomecategoy> createState() => _IncomecategoyState();
}

class _IncomecategoyState extends State<Incomecategoy> {
  @override
  Widget build(BuildContext context) {
    final _nameEditingController = TextEditingController();
    const thisincome = categorytype.income;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 12.5.h,
          elevation: 0.0,
          backgroundColor: Colors.white10,
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 30),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        const Color(0xff0097a7),
                      )),
                      onPressed: () {
                        ShowdCategorupope(context, 'Add Income Category',
                            thisincome, _nameEditingController);
                      },
                      child: const Text("Add some category")),
                ),
              ],
            )
          ],
        ),
        body: ValueListenableBuilder(
            valueListenable: Categoeydb.instense.IncomeCategory,
            builder: (BuildContext context, List<CategoryModel> newList, _) {
              return Categoeydb.instense.IncomeCategory.value.isEmpty
                  ? Center(
                      child: ListView(
                        children: [
                          Image.asset(
                            "assets/undraw_Add_notes_re_ln36-removebg-preview.png",
                            height: 35.h,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Text(
                              "No category trying to add new category",
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250,
                              childAspectRatio: 5 / 2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 9),
                      itemCount: newList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        final category = newList[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: GestureDetector(
                            onLongPress: () {
                              askingDeleting(context, category);
                              setState(() {});
                            },
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              child: ListTile(
                                title: Text(category.name),
                              ),
                            ),
                          ),
                        );
                      });
            }));
  }

  Future askingDeleting(contescx, category) async {
    showDialog(
        context: contescx,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Category deleting"),
            content: SizedBox(
              height: 11.h,
              child: Column(
                children: const [
                  Text(
                    "Are you sure you want to delete the record ? ",
                    style: TextStyle(fontSize: 15),
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
                    Categoeydb.instense.deletecategory(category.id);
                    Navigator.of(ctx).pop();
                    setState(() {});
                  },
                  child: const Text("ok"))
            ],
          );
        });
  }

  Future<void> ShowdCategorupope(BuildContext context, String titel,
      final catrgry, final Texteditcondroller) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("$titel"),
            content: SizedBox(
              height: 20.h,
              child: Column(
                children: [
                  MycustomTextfild(
                    TextEdigcontroller: Texteditcondroller,
                    keyboddesble: true,
                    hinttexts: "Categoryname",
                    icon: MyFlutterApp.pie_chart,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    final name = Texteditcondroller.text.trim();
                    if (name.isEmpty) {
                      return;
                    }
                    final _category = CategoryModel(
                        DateTime.now().microsecondsSinceEpoch.toString(),
                        name: name,
                        categorytype: catrgry);
                    Categoeydb.instense.insertcatgory(_category);
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: const Text("Accept"))
            ],
          );
        });
  }
}
