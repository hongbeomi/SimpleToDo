import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskItemView extends StatefulWidget {

  TaskItemView({Key key, String task}) : super(key: key);

  get task => this.task;

  @override
  _TaskItemViewState createState() => _TaskItemViewState(task: task);

}

class _TaskItemViewState extends State<TaskItemView> {

  _TaskItemViewState({String task});

  get task => this.task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: () {
          print("롱 클릭!");
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