import 'package:flutter/material.dart';
import 'package:todolist/widget/task_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
        children: [TaskCard()],
      );
    }

    ;

    return Scaffold(
      appBar: ToDoAppbar(),
      body: content(),
    );
  }
}
