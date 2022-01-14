import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_tracker/widget/bottom_sheet.dart';
import 'log_in_page.dart';

class TasksPage extends StatelessWidget {
  TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return TaskBottomSheet();
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
