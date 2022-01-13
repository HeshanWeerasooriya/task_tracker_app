import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_tracker/pages/tasks_page.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String userName = '';
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
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            userName = value.toString().trim();
                          },
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return 'Please enter at least 4 characers';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Username',
                            suffixIcon: const Icon(Icons.person),
                            contentPadding: const EdgeInsets.only(
                              left: 20,
                              bottom: 5,
                              right: 5,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: const Color(0xFFFFCBCB)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFFFFCBCB)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value.toString().trim();
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
                              borderSide:
                                  const BorderSide(color: Color(0xFFFFCBCB)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: const Color(0xFFFFCBCB)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Password";
                            }
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
                              borderSide:
                                  const BorderSide(color: Color(0xFFFFCBCB)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFFFFCBCB)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text('Register'),
                          ),
                          onPressed: () async {
                            UserCredential userCredential;
                            if (formkey.currentState!.validate()) {
                              setState(() {
                                isloading = true;
                              });
                              try {
                                userCredential =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email, password: password);

                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userCredential.user?.uid)
                                    .set({
                                  'username': userName,
                                  'email:': email,
                                });
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
                                    title:
                                        const Text(' Ops! Registration Failed'),
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
                              }
                              setState(() {
                                isloading = false;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontFamily: 'balsamiqsans',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            primary: const Color(0xFFFFCBCB),
                            onPrimary: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'I already have an account',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
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
