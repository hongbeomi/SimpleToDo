import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:simpletodo/component/TaskItemView.dart';
import 'package:sqflite/sqflite.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> tasks = [];

  void _addTask() {
    setState(() {
      tasks.add("ㅋㅋ");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              alignment: Alignment.topLeft,
                child: Text(
              widget.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 48,
              ),
            ))),
        Expanded(
            flex: 7,
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              scrollDirection: Axis.vertical,
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return TaskItemView(task: tasks[index] ?? "");
              },
            ))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask();
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
