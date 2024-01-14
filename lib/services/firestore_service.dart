import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  // CREATE : add task
  Future<void> addTask(String task, String description) {
    return tasks.add({
      'title': task,
      'description': description,
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
  Future<void> updateTask(String docID, String newTask, String newDescription) {
    return tasks.doc(docID).update({
      'title': newTask,
      'description': newDescription,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE : delete tasks given a doc id
  Future<void> deleteTask(String docID) {
    return tasks.doc(docID).delete();
  }
}
