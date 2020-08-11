import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simpletodo/component/TaskItemView.dart';
import 'package:simpletodo/data/Task.dart';
import 'package:simpletodo/db/DataBaseHelper.dart';

class HomePage extends StatefulWidget {

  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();

}

class HomePageState extends State<HomePage> {

  void _addTask() {
    setState(() {
      DataBaseHelper().insertData(Task(title: "hello", description: "world"));
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
                color: Colors.white,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 48,
                  ),
                ))),
        Expanded(
            flex: 7,
            child: FutureBuilder(
              future: DataBaseHelper().getAllData(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index, ) {
                      return TaskItemView(task: snapshot.data[index] ?? "", onDelete: refresh);
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
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

  refresh(int id) {
    setState(() {
      DataBaseHelper().deleteData(id);
    });
  }

}
