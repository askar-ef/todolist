// ignore_for_file: prefer_const_constructors
/** 
import 'package:flutter/material.dart';
import 'package:todolist/services/firestore_service.dart';
import 'package:todolist/style.dart';
import 'package:todolist/widget/task_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget ToDoAppbar() {
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

    Widget content() {
      return ListView(
        children: [
          TaskCard(),
        ],
      );
    }

    void addTaskDialog() {
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
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
                      firestoreService.addTask(
                          titleController.text, descriptionController.text);

                      titleController.clear();
                      descriptionController.clear();

                      Navigator.pop(context);
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

    return Scaffold(
      appBar: ToDoAppbar(),
      body: content(),
      floatingActionButton: addTaskButton(),
    );
  }
}
*/