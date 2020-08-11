import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simpletodo/component/deleteDialog.dart';

class TaskItemView extends StatefulWidget {
  TaskItemView({Key key, this.task}) : super(key: key);
  final String task;

  @override
  _TaskItemViewState createState() => _TaskItemViewState(task: task);
}

class _TaskItemViewState extends State<TaskItemView> {
  _TaskItemViewState({this.task});

  final String task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) => DeleteDialog(context: context));
        },
        child: Card(
          color: Color.fromARGB(100, 243, 243, 247),
          child: Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            height: 56,
            child: Text(task ?? ""),
          ),
        ));
  }
}