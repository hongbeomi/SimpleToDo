import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpletodo/presentation/component/task_item_view.dart';
import 'package:simpletodo/data/model/task.dart';
import 'package:simpletodo/presentation/task_view_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  final String title = 'All Task';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
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
              future: viewModel.loadTasks(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (
                          BuildContext context,
                          int index,
                        ) {
                          return TaskItemView(
                            key: UniqueKey(),
                            task: snapshot.data[index] ?? [],
                            onDelete: () {
                                viewModel.deleteTask(snapshot.data[index].id);
                            },
                          );
                        },
                      )
                    : Center(child: CircularProgressIndicator());
              },
            ))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.insertTask(
              Task(title: "hello", description: "world", isFinish: 1));
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
