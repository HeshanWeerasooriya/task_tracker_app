import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/task.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class DataRepository {
  final CollectionReference collection = FirebaseFirestore.instance
      .collection('tasks')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('task');

  Future getCurrentUser() async {
    return auth.currentUser;
  }

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addTask(Task task) {
    return collection.add(task.toJson());
  }

  void updateTask(Task task) async {
    await collection.doc(task.referenceId).update(task.toJson());
  }

  void deleteTask(Task task) async {
    await collection.doc(task.referenceId).delete();
  }
}
