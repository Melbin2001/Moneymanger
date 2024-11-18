import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanager/transaction_db/transaction_model.dart';

const _transaction_dbname = 'transaction database';

abstract class Transactiondbfunctions {
  Future<void> Addtransaction(TransactionModel obj);
  Future<List<TransactionModel>> getalltransactions();
  Future<void> deletetransaction(String id);
}

class Transactiondb implements Transactiondbfunctions {
  Transactiondb._internal();
  static Transactiondb instance = Transactiondb._internal();
  factory Transactiondb() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionlistnoty = ValueNotifier([]);
  @override
  Future<void> Addtransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(_transaction_dbname);
    await db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final List = await getalltransactions();
    List.sort((first, second) => second.date.compareTo(first.date));
    transactionlistnoty.value.clear();
    transactionlistnoty.value.addAll(List);
    transactionlistnoty.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getalltransactions() async {
    final db = await Hive.openBox<TransactionModel>(_transaction_dbname);
    return db.values.toList();
  }

  @override
  Future<void> deletetransaction(String id) async {
    final db = await Hive.openBox<TransactionModel>(_transaction_dbname);
    await db.delete(id);
    refresh();
  }
}
