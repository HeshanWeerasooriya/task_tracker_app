import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? referenceId;
  String title;
  String userId;

  Task(
    this.title,
    this.userId, {
    this.referenceId,
  });

  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    final newTask = Task.fromJson(snapshot.data() as Map<String, dynamic>);
    newTask.referenceId = snapshot.reference.id;
    return newTask;
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return _taskFromJson(json);
  }

  Map<String, dynamic> toJson() => _taskToJson(this);

  @override
  String toString() => 'Task<$title>';
}

Task _taskFromJson(Map<String, dynamic> json) {
  return Task(
    json['title'] as String,
    json['userId'] as String,
  );
}

Map<String, dynamic> _taskToJson(Task instance) {
  return <String, dynamic>{
    'title': instance.title,
    'userId': instance.userId,
  };
}
