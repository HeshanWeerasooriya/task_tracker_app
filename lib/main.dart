import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_tracker/pages/log_in_page.dart';
import 'package:task_tracker/pages/tasks_page.dart';
import 'package:task_tracker/pages/sign_up_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 245, 231, 189),
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginScreen()
          : TasksPage(),
    );
  }
}
