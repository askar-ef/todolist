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
  final TextEditingController textController = TextEditingController();

  // adding task dialog
  void openNoteBox({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      // if doc id == null
                      if (docID == null) {
                        // add new task
                        firestoreService.addTask(textController.text);

                        // clear dialog
                        textController.clear();

                        // close dialog
                        Navigator.pop(context);
                      }
                      // if doc
                      else {
                        // update task
                        firestoreService.updateTask(docID, textController.text);

                        // clear dialog
                        textController.clear();

                        // close dialog
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('add'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TO DO',
          style: primaryTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(201, 19, 123, 197),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openNoteBox();
        },
        child: const Icon(Icons.add),
      ),
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
                String taskText = data['task'];

                // display as a list tile
                return ListTile(
                  title: Text(taskText),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      onPressed: () {
                        openNoteBox(docID: docID);
                      },
                      icon: const Icon(Icons.settings),
                    ),
                    IconButton(
                        onPressed: () {
                          firestoreService.deleteTask(docID);
                        },
                        icon: const Icon(Icons.delete))
                  ]),
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
