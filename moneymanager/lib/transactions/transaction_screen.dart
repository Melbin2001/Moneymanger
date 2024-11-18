import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager/db/category/category_model.dart';
import 'package:moneymanager/db/transactions/transaction_model.dart';
import 'package:moneymanager/models/category/category_model.dart';
import 'package:moneymanager/transaction_db/transaction_model.dart';

class Transactionscreen extends StatelessWidget {
  const Transactionscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Transactiondb.instance.refresh();
    Categorydb.instance.refreshui();
    return ValueListenableBuilder(
        valueListenable: Transactiondb.instance.transactionlistnoty,
        builder: (BuildContext ctx, List<TransactionModel> newlist, Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(15),
              itemBuilder: (ctx, index) {
                final value = newlist[index];
                return Slidable(
                  key: Key(value.id!),
                  startActionPane:
                      ActionPane(motion: ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (ctx) {Transactiondb.instance.deletetransaction(value.id!);},
                      icon: Icons.delete,
                      foregroundColor: value.type == categorytype.income
                          ? const Color.fromARGB(255, 32, 214, 38)
                          : const Color.fromARGB(255, 243, 20, 4),
                    )
                  ]),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: value.type == categorytype.income
                              ? const Color.fromARGB(255, 32, 214, 38)
                              : const Color.fromARGB(255, 243, 20, 4),
                          child: Text(
                            parsedate(value.date),
                            style: TextStyle(
                                color: value.type == categorytype.income
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          )),
                      title: Text(
                        'RS ${value.amount}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      trailing: Text(
                        value.category.name,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 7,
                );
              },
              itemCount: newlist.length);
        });
  }

  String parsedate(DateTime date) {
    final date0 = DateFormat.MMMd().format(date);
    final splitdate = date0.split(' ');
    return '${splitdate.last}\n${splitdate.first}';
  }
}
