import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:simpletodo/data/model/task.dart';

class ImageDetailScreen extends StatelessWidget {
  ImageDetailScreen(this.task, this.heroKey);

  final Task task;
  final String heroKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Column(children: [
          Expanded(
            flex: 4,
            child: Hero(
                tag: heroKey,
                child: task.path.isNotEmpty
                    ? Image.file(File(task.path))
                    : getDummyImage()),
          ),
          Expanded(
            flex: 6,
            child: Neumorphic(
              margin: EdgeInsets.all(24),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              style: NeumorphicStyle(
                depth: -3.0,
                intensity: 1.0,
                boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.all(Radius.circular(8))),
              ),
              child: Center(
                child: Text(
                  task.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ]),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

getDummyImage() {
  return Image.asset(
    "assets/image_2.jpg",
    fit: BoxFit.fill,
  );
}
