import 'package:flutter/material.dart';
import 'package:simpletodo/data/model/task.dart';
import 'package:simpletodo/data/repository/task_local_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskLocalRepository repository = TaskLocalRepository();

  Future<List<Task>> loadTasks() async {
    return await repository.loadTasks().then((loadedTasks) {
      return loadedTasks;
    }).catchError((e) {
      return [];
    });
  }

  void updateTask(Task task) {
    repository.updateTask(task);
    notifyListeners();
  }

  void insertTask(Task task) {
    repository.insertTask(task);
    notifyListeners();
  }

  void deleteTask(int id) {
    repository.deleteTask(id);
    notifyListeners();
  }
}
