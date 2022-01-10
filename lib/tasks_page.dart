import 'package:flutter/material.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'T A S K   T R A C K E R',
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}
