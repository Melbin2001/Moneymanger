import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/home/home_screen.dart';
import 'package:moneymanager/login_page/signin_page.dart';

class Sign_up_page extends StatefulWidget {
  const Sign_up_page({super.key});

  @override
  State<Sign_up_page> createState() => _Sign_up_pageState();
}

class _Sign_up_pageState extends State<Sign_up_page> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
   final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 78,
        backgroundColor: const Color.fromARGB(255, 6, 211, 13),
        title: const Text(
          'Sign Up',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                 validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'username is empty';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                 validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'email is empty';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: 'enter your email',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
                controller: _emailController,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                 validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'password is empty';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: 'enter your password',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          const Color.fromARGB(255, 37, 219, 43))),
                  onPressed: () {
                      if (_formkey.currentState!.validate()) {
                      _signUp();
                    } else {
                      print('data is empty');
                    }
                   
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
                  )),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Return to',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => Login_page()));
                      },
                      child: Text(
                        'Login?',
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 38, 218, 44)),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Handle successful sign-up
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Homescreen()));
    } catch (e) {
      // Handle sign-up error
      print('Sign Up Failed: $e');
    }
  }
}
