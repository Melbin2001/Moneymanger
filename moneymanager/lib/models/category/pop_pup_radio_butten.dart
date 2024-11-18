import 'package:flutter/material.dart';
import 'package:moneymanager/db/category/category_model.dart';
import 'package:moneymanager/models/category/category_model.dart';

ValueNotifier<categorytype> selectedcategory =
    ValueNotifier(categorytype.income);

Future<void> showcategory(BuildContext context) async {
  final nameeditingcontroller = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: SimpleDialog(
            title: Center(
                child: Text(
              'Select Category',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            )),
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: nameeditingcontroller,
                  decoration: InputDecoration(
                      hintText: 'Enter Category',
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 141, 138, 138)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40))),
                ),
              ),
              Row(
                children: [
                  Radiobutton(title: 'Income', type: categorytype.income),
                  Radiobutton(title: 'Expense', type: categorytype.expense)
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 10, 60, 15),
                child: ElevatedButton(
                  onPressed: () {
                    final name = nameeditingcontroller.text;
                    if (name.isEmpty) {
                      return;
                    }
                    final type = selectedcategory.value;
                    final category = CategoryModel(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        name: name,
                        type: type);
                    Categorydb.instance.insertcategory(category);
                    Navigator.of(ctx).pop();
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          const Color.fromARGB(255, 40, 201, 45))),
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        );
      });
}

class Radiobutton extends StatelessWidget {
  final String title;
  final categorytype type;

  const Radiobutton({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedcategory,
            builder:
                (BuildContext ctx, categorytype newcategorytype, Widget? _) {
              return Radio<categorytype>(
                  value: type,
                  groupValue: newcategorytype,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectedcategory.value = value;
                    selectedcategory.notifyListeners();
                  });
            }),
        Text(title)
      ],
    );
  }
}
