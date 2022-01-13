import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_tracker/pages/tasks_page.dart';
import 'sign_up_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formkey,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 30),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            suffixIcon: const Icon(Icons.email),
                            contentPadding: const EdgeInsets.only(
                              left: 20,
                              bottom: 5,
                              right: 5,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFFFFCBCB)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFFFFCBCB)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'Password must be least at 7 characers long';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            suffixIcon: const Icon(Icons.password),
                            contentPadding: const EdgeInsets.only(
                              left: 20,
                              bottom: 5,
                              right: 5,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFFFFCBCB)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFFFFCBCB)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          // ignore: prefer_const_constructors
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: const Text('Login'),
                          ),
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontFamily: 'balsamiqsans',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            primary: Color(0xFFFFCBCB),
                            onPrimary: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              setState(() {
                                isloading = true;
                              });
                              try {
                                await _auth.signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (contex) => TasksPage(),
                                  ),
                                );
                                setState(() {
                                  isloading = false;
                                });
                              } on FirebaseAuthException catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text("Ops! Login Failed"),
                                    content: Text('${e.message}'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: const Text('Okay'),
                                      )
                                    ],
                                  ),
                                );
                                print(e);
                              }
                              setState(() {
                                isloading = false;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                          child: const Text(
                            'Create new account',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
