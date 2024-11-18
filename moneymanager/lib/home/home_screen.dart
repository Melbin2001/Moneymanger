import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/addtransaction/screen_add_trans.dart';
import 'package:moneymanager/category/category_screen.dart';
import 'package:moneymanager/home/widgets/bottom_navigation.dart';
import 'package:moneymanager/login_page/signin_page.dart';
import 'package:moneymanager/models/category/pop_pup_radio_butten.dart';
import 'package:moneymanager/transactions/transaction_screen.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});
  static ValueNotifier<int> selectedindex = ValueNotifier(0);
  final _pages = [const Transactionscreen(), const Categoryscreen()];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 222, 222),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _logout(context);
            },
            icon: Icon(Icons.logout)),
        toolbarHeight: 85,
        backgroundColor: const Color.fromARGB(255, 6, 211, 13),
        title: const Text(
          'Money Manager',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const Moneymanagerbottomnavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedindex,
              builder: (BuildContext context, int updatedindex, _) {
                return _pages[updatedindex];
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 6, 211, 13),
        onPressed: () {
          if (selectedindex.value == 0) {
            Navigator.of(context).pushNamed(Addscreen.routeName);
          } else {
            print('add some');
            showcategory(context);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _logout(ctx1) async {
    try {
      await _auth.signOut();
      Navigator.of(ctx1).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
        return Login_page();
      }), (Route) => false);
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
