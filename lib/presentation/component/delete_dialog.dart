import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends CupertinoAlertDialog {
  DeleteDialog({this.context, @required this.id});

  final int id;
  final BuildContext context;

  @override
  Widget get title => Text("제거");

  @override
  Widget get content => Text("task를 지우시겠습니까?");

  @override
  List<Widget> get actions => <Widget>[
        CupertinoDialogAction(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => Navigator.pop(context, true)),
        CupertinoDialogAction(
            child: Text("Cancel", style: TextStyle(color: Colors.lightBlue)),
            onPressed: () => Navigator.pop(context, false))
      ];
}
