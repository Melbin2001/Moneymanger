import 'package:flutter/material.dart';
import 'package:moneymanager/db/category/category_model.dart';
import 'package:moneymanager/db/transactions/transaction_model.dart';
import 'package:moneymanager/models/category/category_model.dart';
import 'package:moneymanager/transaction_db/transaction_model.dart';

class Addscreen extends StatefulWidget {
  const Addscreen({super.key});
  static const routeName = 'Add transactions';

  @override
  State<Addscreen> createState() => _AddscreenState();
}

class _AddscreenState extends State<Addscreen> {
  DateTime? _selectdate;
  categorytype? _selectedcategorytype;
  CategoryModel? _selectedcategorymodel;
  String? _categoryID;
  @override
  void initState() {
    _selectedcategorytype = categorytype.income;
    super.initState();
  }

  final _purposeTexteditingcontroler = TextEditingController();
  final _Amounteditingcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextFormField(
                controller: _purposeTexteditingcontroler,
                decoration: InputDecoration(
                    hintText: 'Purpose',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: _Amounteditingcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Amount',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)))),
              SizedBox(
                height: 25,
              ),
              TextButton.icon(
                onPressed: () async {
                  final selecteddatetemp = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(Duration(days: 30)),
                      lastDate: DateTime.now());
                  if (selecteddatetemp == null) {
                    return;
                  } else {
                    print(selecteddatetemp.toString());
                    setState(() {
                      _selectdate = selecteddatetemp;
                    });
                  }
                },
                label: Text(
                  _selectdate == null ? 'Select date' : _selectdate.toString(),
                  style: TextStyle(color: Colors.black),
                ),
                icon: Icon(
                  Icons.calendar_today_sharp,
                  color: Color.fromARGB(255, 26, 150, 31),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                          focusColor: Colors.green,
                          activeColor: const Color.fromARGB(255, 26, 150, 31),
                          value: categorytype.income,
                          groupValue: _selectedcategorytype,
                          onChanged: (newvalue) {
                            setState(() {
                              _selectedcategorytype = categorytype.income;
                              _categoryID = null;
                            });
                          }),
                      Text(
                        'Income',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          focusColor: Colors.green,
                          activeColor: const Color.fromARGB(255, 26, 150, 31),
                          value: categorytype.expense,
                          groupValue: _selectedcategorytype,
                          onChanged: (newvalue) {
                            setState(() {
                              _selectedcategorytype = categorytype.expense;
                              _categoryID = null;
                            });
                          }),
                      Text(
                        'Expense',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
              DropdownButton(
                  hint: Text('Select category'),
                  value: _categoryID,
                  items: (_selectedcategorytype == categorytype.income
                          ? Categorydb.instance.Incomecategorylist
                          : Categorydb.instance.Expensecategorylist)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: () {
                        print(e.toString());
                        _selectedcategorymodel = e;
                      },
                    );
                  }).toList(),
                  onChanged: (selectedvalue) {
                    print(selectedvalue);
                    setState(() {
                      _categoryID = selectedvalue;
                    });
                  }),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 56, 212, 61))),
                  onPressed: () {
                    addtransaction();
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addtransaction() async {
    final purpose = _purposeTexteditingcontroler.text;
    final amount = _Amounteditingcontroller.text;
    if (purpose.isEmpty) {
      return;
    }
    if (amount.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (_selectdate == null) {
      return;
    }
    final parseamount = double.tryParse(amount);
    if (parseamount == null) {
      return;
    }
    final model = TransactionModel(
        purpose: purpose,
        amount: parseamount,
        date: _selectdate!,
        type: _selectedcategorytype!,
        category: _selectedcategorymodel!);
    Transactiondb.instance.Addtransaction(model);
    Navigator.of(context).pop();
    Transactiondb.instance.refresh();
  }
}
