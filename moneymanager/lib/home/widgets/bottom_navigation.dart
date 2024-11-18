import 'package:flutter/material.dart';
import 'package:moneymanager/home/home_screen.dart';

class Moneymanagerbottomnavigation extends StatelessWidget {
  const Moneymanagerbottomnavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Homescreen.selectedindex,
      builder: (BuildContext ctx, int updatedindex, Widget? _) {
        return BottomNavigationBar(
            currentIndex: updatedindex,
            onTap: (newindex) {
              Homescreen.selectedindex.value = newindex;
            },
            selectedItemColor: const Color.fromARGB(255, 6, 211, 13),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Transactions'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category')
            ]);
      },
    );
  }
}
