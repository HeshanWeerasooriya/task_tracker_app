import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_tracker/widget/bottom_sheet.dart';
import '../model/task.dart';
import '../repository/data_repository.dart';
import '../widget/task_tile.dart';
import 'log_in_page.dart';

class TasksPage extends StatelessWidget {
  TasksPage({Key? key}) : super(key: key);

  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView(
            gridDelegate: (const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            )),
            children: snapshot.data!.docs
                .map((data) => _buildListItem(context, data))
                .toList(),
          );
        },
      ),
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

Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
  final task = Task.fromSnapshot(snapshot);

  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TaskTile(tasks: task),
  );
}
