// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/services/firestore_service.dart';
import 'package:todolist/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // firestore
  final FirestoreService firestoreService = FirestoreService();

  // text controller
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // adding task dialog
  void openNoteBox({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: titleController,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      // if doc id == null
                      if (docID == null) {
                        // add new task
                        firestoreService.addTask(
                            titleController.text, descriptionController.text);

                        // clear dialog
                        titleController.clear();
                        descriptionController.clear();

                        // close dialog
                        Navigator.pop(context);
                      }
                      // if doc
                      else {
                        // update task
                        firestoreService.updateTask(docID, titleController.text,
                            descriptionController.text);

                        // clear dialog
                        titleController.clear();
                        descriptionController.clear();

                        // close dialog
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('add'))
              ],
            ));
  }

  PreferredSizeWidget toDoAppbar() {
    return AppBar(
      title: Text('To Do App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.menu_book),
          onPressed: () {},
        )
      ],
    );
  }

  void addTaskDialog({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ADD TASK',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(10)),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        labelText: 'Description',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(10)),
                    maxLines: 4,
                  )
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    if (docID == null) {
                      firestoreService.addTask(
                          titleController.text, descriptionController.text);

                      titleController.clear();
                      descriptionController.clear();

                      Navigator.pop(context);
                    } else {
                      // update task
                      firestoreService.updateTask(docID, titleController.text,
                          descriptionController.text);

                      // clear dialog
                      titleController.clear();
                      descriptionController.clear();

                      // close dialog
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.check_rounded),
                )
              ],
            ));
  }

  Widget addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        addTaskDialog();
      },
      backgroundColor: primaryColor,
      child: Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appbar
      appBar: toDoAppbar(),

      /// floating action button
      floatingActionButton: addTaskButton(),

      /// body
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getTasksStream(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List tasksList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: tasksList.length,
              itemBuilder: (context, index) {
                // get individual doc
                DocumentSnapshot document = tasksList[index];
                String docID = document.id;

                // get task from each doc
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String title = data['title'];
                String description = data['description'];

                // Mengambil nilai timestamp
                Timestamp timestamp = data['timestamp'] as Timestamp;

                // Mengonversi timestamp menjadi objek DateTime
                DateTime dateTime = timestamp.toDate();

                // Mengambil nilai tanggal (format: yyyy-mm-dd)
                String date =
                    "${dateTime.year}-${dateTime.month.toString()}-${dateTime.day.toString()}";

                // display as a list tile
                return Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  padding: EdgeInsets.only(left: 14, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black12),
                  child: ListTile(
                    title: Text(
                      title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            description,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            date,
                            style: TextStyle(fontSize: 12),
                          ),
                        ]),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                        onPressed: () {
                          addTaskDialog(docID: docID);
                        },
                        icon: const Icon(Icons.settings),
                      ),
                      IconButton(
                          onPressed: () {
                            firestoreService.deleteTask(docID);
                          },
                          icon: const Icon(Icons.delete))
                    ]),
                  ),
                );
              },
            );
          } else {
            return const Text(' No Task');
          }
        }),
      ),
    );
  }
}
