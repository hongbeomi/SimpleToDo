import 'package:flutter/foundation.dart';

class Task {
  final int id;
  final String title;

  // 0 true, 1 false
  final int isFinish;

  Task({this.id, this.title, this.isFinish});

  toMap() => {
        'id': id,
        'title': title,
        'isFinish': isFinish
      };

  copy({@required int id, String title, int isFinish}) =>
      Task(
          id: id,
          title: title ?? this.title,
          isFinish: isFinish ?? this.isFinish);

  @override
  String toString() =>
      id.toString() +
      " " +
      title +
      " " +
      isFinish.toString();
}
