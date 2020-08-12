import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpletodo/component/delete_dialog.dart';
import 'package:simpletodo/data/task.dart';
import 'package:simpletodo/task_view_model.dart';

class TaskItemView extends StatefulWidget {
  TaskItemView({Key key, @required this.task}) : super(key: key);

  final Task task;

  @override
  _TaskItemViewState createState() => _TaskItemViewState(this.task);
}

class _TaskItemViewState extends State<TaskItemView> {
  _TaskItemViewState(Task task) {
    this.task = task;
    this._isFinish = task.isFinish == 0 ?? false;
  }

  Task task;
  bool _isFinish;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);

    return InkWell(
        onLongPress: () async {
          bool result = await showDialog(
              context: context,
              builder: (context) => DeleteDialog(
                    context: context,
                    id: task.id,
                  ));
          if (result) {
            viewModel.deleteTask(task.id);
          }
        },
        child: Card(
          color: Color.fromARGB(100, 243, 243, 247),
          child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _isFinish,
                  title: Text(task.description,
                      style: _isFinish
                          ? TextStyle(decoration: TextDecoration.lineThrough)
                          : null),
                  onChanged: (isChecked) {
                    setState(() {
                      _isFinish = isChecked;
                      viewModel.updateTask(
                          task.copy(id: task.id, isFinish: _isFinish ? 0 : 1));
                    });
                  })),
        ));
  }
}
