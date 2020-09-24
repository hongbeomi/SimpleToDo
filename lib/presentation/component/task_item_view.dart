import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:simpletodo/data/model/task.dart';
import 'package:simpletodo/presentation/page/detail_page.dart';
import 'package:simpletodo/presentation/viewmodel/task_view_model.dart';

class TaskItemView extends StatefulWidget {
  const TaskItemView(
      {Key key,
      @required this.task,
      this.scale,
      this.scaleDepth})
      : super(key: key);

  final Task task;
  final double scale;
  final double scaleDepth;

  @override
  _TaskItemViewState createState() =>
      _TaskItemViewState(this.task, this.scale, this.scaleDepth);
}

class _TaskItemViewState extends State<TaskItemView> {
  _TaskItemViewState(this.task, this.scale, this.scaleDepth) {
    this._isFinish = task.isFinish == 0;
  }

  final Task task;
  final double scale;
  final double scaleDepth;

  bool _isFinish;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);

    return Transform.scale(
        scale: scale,
        alignment: Alignment.centerLeft,
        child: Neumorphic(
            margin: EdgeInsets.fromLTRB(0, 32, 32, 32),
            style: NeumorphicStyle(
              depth: NeumorphicTheme.depth(context) * 2 * scaleDepth,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
            ),
            child: Column(children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ImageDetailScreen(task, imageKey(task.id));
                    }));
                  },
                  child: Hero(tag: imageKey(task.id), child: loadImage()),
                ),
              ),
              CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _isFinish,
                  checkColor: Colors.white,
                  activeColor: Colors.blueAccent,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 24.0),
                  title: Text(task.title,
                      overflow: TextOverflow.ellipsis,
                      style: _isFinish
                          ? TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 20,
                              fontWeight: FontWeight.w300)
                          : TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300)),
                  onChanged: (isChecked) {
                    setState(() {
                      _isFinish = isChecked;
                    });
                    viewModel.updateTask(task.copy(
                        id: task.id, isFinish: _isFinish ? 0 : 1));
                  }),
            ])));
  }

  loadImage() {
    return task.path.isEmpty
        ? getDummyImage()
        : Image.file(File(task.path), fit: BoxFit.fill);
  }

  String imageKey(int key) {
    return "image$key";
  }

}
