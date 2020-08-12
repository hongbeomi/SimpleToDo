import 'package:flutter/foundation.dart';

class Task {
  final int id;
  final String title;
  final String description;

  // 0 true, 1 false
  final int isFinish;

  Task({this.id, this.title, this.description, this.isFinish});

  toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'isFinish': isFinish
      };

  copy({@required int id, String title, String description, int isFinish}) => Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isFinish: isFinish ?? this.isFinish);
}
