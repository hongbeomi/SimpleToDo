import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:simpletodo/data/model/task.dart';
import '../task_view_model.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  final String title = 'New Task';

  @override
  AddPageState createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  String _title = "";
  bool _result = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, _result),
          color: Colors.black,
          alignment: Alignment(1.0, 0.0),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              alignment: Alignment.topLeft,
              color: Colors.white,
              child: Text(
                widget.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 48,
                    fontWeight: FontWeight.w700),
              )),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle:
                      TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                  border: InputBorder.none),
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              maxLines: null,
              onChanged: (title) => _title = title,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkTitleEmpty(
              () => {viewModel.insertTask(Task(title: _title, isFinish: 1))});
          Navigator.pop(context, _result);
        },
        tooltip: 'Add Task',
        child: Icon(Icons.check),
        backgroundColor: Colors.green,
      ),
    );
  }

  checkTitleEmpty(Function insertAction) {
    if (_title.isNotEmpty) {
      insertAction();
      _result = true;
    } else {
      _result = false;
    }
  }
}
