// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todolist/style.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: primaryColor,
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(14),
      child: Row(
        children: const [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Judul Task
              Text(
                'Judul Utama',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              // Rincian Task
              Text('Rincian Task'),
              SizedBox(
                height: 20,
              ),

              // Tanggal Task
              Text(
                'Tanggal Task',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10),
              ),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.format_quote_rounded),
              SizedBox(width: 10),
              Icon(Icons.task_alt),
              SizedBox(width: 10),
            ],
          )
        ],
      ),
    );
  }
}
