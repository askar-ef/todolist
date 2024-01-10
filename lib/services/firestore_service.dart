import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  // CREATE : add task
  Future<void> addTask(String task) {
    return tasks.add({
      'task': task,
      'timestamp': Timestamp.now(),
    });
  }

  // READ : get tasks from database
  Stream<QuerySnapshot> getTasksStream() {
    final tasksStream =
        tasks.orderBy('timestamp', descending: true).snapshots();

    return tasksStream;
  }

  // UPDATE : update tasks given a doc id
  Future<void> updateTask(String docID, String newTask) {
    return tasks.doc(docID).update({
      'task': newTask,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE : delete tasks given a doc id
  Future<void> deleteTask(String docID) {
    return tasks.doc(docID).delete();
  }
}
