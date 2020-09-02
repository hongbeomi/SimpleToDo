import 'package:flutter/foundation.dart';

class Task {
  final int id;
  final String title;
  final String path;

  // 0 true, 1 false
  final int isFinish;

  Task(
      {this.id,
      @required this.title,
      @required this.path,
      @required this.isFinish});

  toMap() => {'id': id, 'title': title, 'path': path, 'isFinish': isFinish};

  copy({@required int id, String title, String path, int isFinish}) => Task(
      id: id,
      title: title ?? this.title,
      path: path ?? this.path,
      isFinish: isFinish ?? this.isFinish);

  @override
  String toString() =>
      id.toString() + " " + title + " " + path + " " + isFinish.toString();
}
