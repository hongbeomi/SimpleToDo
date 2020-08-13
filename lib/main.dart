import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpletodo/presentation/page/add_page.dart';
import 'package:simpletodo/presentation/page/home_page.dart';
import 'package:simpletodo/presentation/task_view_model.dart';

void main() => runApp(SimpleToDo());
const ADD_PAGE = '/add';

class SimpleToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<TaskViewModel>(
      create: (context) => TaskViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "NotoSansKR",
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
        routes: {
          ADD_PAGE : (context) => AddPage(),
        },
      ));
}
