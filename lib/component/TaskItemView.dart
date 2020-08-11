import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simpletodo/component/DeleteDialog.dart';
import 'package:simpletodo/data/Task.dart';
import 'package:simpletodo/db/DataBaseHelper.dart';
import 'package:simpletodo/page/HomePage.dart';

class TaskItemView extends StatefulWidget {
  TaskItemView({Key key, @required this.task, @required this.onDelete})
      : super(key: key);
  final Task task;
  final Function(int) onDelete;

  @override
  _TaskItemViewState createState() => _TaskItemViewState(task: task, onDelete: onDelete);
}

class _TaskItemViewState extends State<TaskItemView> {
  _TaskItemViewState({this.task, this.onDelete});

  final Function(int) onDelete;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: () async {
          bool result = await showDialog(
              context: context,
              builder: (context) => DeleteDialog(
                    context: context,
                    id: task.id,
                  ));
          if (result) {
            onDelete.call(task.id);
          }
        },
        child: Card(
          color: Color.fromARGB(100, 243, 243, 247),
          child: Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            height: 64,
            child: Text(task.description),
          ),
        ));
  }
}
