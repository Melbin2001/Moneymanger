import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moneymanager/home/home_screen.dart';
import 'package:moneymanager/login_page/signin_page.dart';

class Splas_screen extends StatefulWidget {
  const Splas_screen({super.key});

  @override
  State<Splas_screen> createState() => _Splas_screenState();
}

class _Splas_screenState extends State<Splas_screen> {
  @override
  void initState() {
    checklogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        SizedBox(  height:650 ,width:600, child: Lottie.asset('Assets/animations/Animation - 1730229150558 (1).json')),
        SizedBox(
          height: 50,
        ),
        Text('Powerd By\n  MELBIN',style: TextStyle(color: Colors.black,fontWeight:FontWeight.w600),)
      ],
    )));
  }

  Future<void> checklogin() async {
     await Future.delayed(Duration(seconds: 2));
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx1) {
        return Homescreen();
      }));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx1) {
        return Login_page();
      }));
    }
  }
}
