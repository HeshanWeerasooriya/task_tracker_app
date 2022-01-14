import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/task.dart';
import '../repository/data_repository.dart';

class TaskBottomSheet extends StatefulWidget {
  TaskBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  late String taskTitle;
  var currentUser = FirebaseAuth.instance.currentUser;
  User? loggedInUser;
  bool isloading = false;
  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFFDDE),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              height: 210,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter task title ',
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
                      onChanged: (text) => taskTitle = text,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isloading = true;
                        });
                        final newTask = Task(taskTitle, (currentUser!.uid));
                        repository.addTask(newTask);
                        Navigator.pop(context);
                        setState(() {
                          isloading = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text('Add Task'),
                      ),
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
                  ],
                ),
              ),
            ),
    );
  }
}
