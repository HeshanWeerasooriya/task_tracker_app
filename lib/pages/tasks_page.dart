import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'log_in_page.dart';

class TasksPage extends StatelessWidget {
  TasksPage({Key? key}) : super(key: key);

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  _signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            child: Text('Log out'),
            onPressed: () async {
              await _signOut();
              if (_firebaseAuth.currentUser == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            }),
      ),
    );
  }
}
