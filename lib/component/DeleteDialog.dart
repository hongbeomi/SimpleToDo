import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends CupertinoAlertDialog {

  DeleteDialog({this.context});

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
          onPressed: () {
            print("삭제!");
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text("Cancel", style: TextStyle(color: Colors.lightBlue)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ];

}
