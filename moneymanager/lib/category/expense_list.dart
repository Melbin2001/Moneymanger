import 'package:flutter/material.dart';
import 'package:moneymanager/db/category/category_model.dart';
import 'package:moneymanager/models/category/category_model.dart';

class Expenselist extends StatelessWidget {
  const Expenselist({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Categorydb().Expensecategorylist,
        builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final Category = newlist[index];
                return ListTile(
                    title: Text(
                      Category.name,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Categorydb.instance.deletecategory(Category.id);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: const Color.fromARGB(255, 197, 20, 8),
                        )));
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: newlist.length);
        });
  }
}
