import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends CupertinoAlertDialog {

  DeleteDialog({this.context});

  final BuildContext context;

  @override
  Widget get title => Text("Delete");

  @override
  Widget get content => Text("task를 삭제하시겠습니까?");

  @override
  List<Widget> get actions => <Widget>[
        CupertinoDialogAction(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            print("삭제!");
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
