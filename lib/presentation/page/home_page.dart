import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpletodo/presentation/component/task_item_view.dart';
import 'package:simpletodo/data/model/task.dart';
import 'package:simpletodo/presentation/page/add_page.dart';
import 'package:simpletodo/presentation/viewmodel/task_view_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  final String title = 'All Task';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: true);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(children: <Widget>[
        Expanded(
            flex: 1,
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
                ))),
        Expanded(
            flex: 7,
            child: FutureBuilder(
              future: viewModel.loadTasks(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                return snapshot.hasData
                    ? ListView.separated(
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
                              onDelete: () => viewModel
                                  .deleteTask(snapshot.data[index].id));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 8);
                        },
                      )
                    : Center(child: CircularProgressIndicator());
              },
            ))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool result = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPage()));
          if (result == true) {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(
                "Add Task!",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              backgroundColor: Colors.blue,
            ));
          }
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
