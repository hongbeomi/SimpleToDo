import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpletodo/presentation/component/delete_dialog.dart';
import 'package:simpletodo/data/model/task.dart';
import 'package:simpletodo/presentation/task_view_model.dart';

class TaskItemView extends StatefulWidget {

  TaskItemView({Key key, @required this.task, @required this.onDelete}) : super(key: key);

  final void Function(BuildContext context) onDelete;
  final Task task;

  @override
  _TaskItemViewState createState() => _TaskItemViewState(this.task, this.onDelete);
}

class _TaskItemViewState extends State<TaskItemView> {
  _TaskItemViewState(this.task, this.onDelete) {
    print(task.id);
    this._isFinish = task.isFinish == 0 ?? false;
  }

  final void Function(BuildContext context) onDelete;
  final Task task;
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
          if (result == true) {
            onDelete(context);
//            viewModel.deleteTask(task.id);
          }
        },
        child: Card(
          color: Colors.white,
          elevation: 6.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Container(
              alignment: Alignment.center,
              child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _isFinish,
                  title: Text(task.description,
                      textAlign: TextAlign.right,
                      style: _isFinish
                          ? TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 20)
                          : TextStyle(fontSize: 20)),
                  onChanged: (isChecked) {
                    setState(() {
                      _isFinish = isChecked;
                    });
                    viewModel.updateTask(
                        task.copy(id: task.id, isFinish: _isFinish ? 0 : 1));
                  })),
        ));
  }
}