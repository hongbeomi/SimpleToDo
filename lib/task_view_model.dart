import 'package:flutter/material.dart';
import 'package:simpletodo/data/task.dart';
import 'package:simpletodo/repository/task_local_repository.dart';

class TaskViewModel with ChangeNotifier {

  final TaskLocalRepository repository = TaskLocalRepository();

  Future<List<Task>> loadTasks() {
    return repository.loadTasks().then((loadedTasks) {
      notifyListeners();
      return loadedTasks;
    }).catchError((e) {
      notifyListeners();
      return [];
    });
  }

  void updateTask(Task task) {
    print("ID :: ${task.id}");
    print("isFinish :: ${task.isFinish}");
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