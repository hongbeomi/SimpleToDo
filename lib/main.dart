import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(SimpleToDo());
}

class SimpleToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'All Task'),
    );
  }
}
