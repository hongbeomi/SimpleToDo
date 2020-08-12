import 'package:flutter/material.dart';
import 'package:simpletodo/data/model/task.dart';
import 'package:simpletodo/data/repository/task_local_repository.dart';

class TaskViewModel with ChangeNotifier {

  final TaskLocalRepository repository = TaskLocalRepository();

  Future<List<Task>> loadTasks() async {
    return await repository.loadTasks()
        .then((loadedTasks) {
      notifyListeners();
      return loadedTasks;
    }).catchError((e) {
      notifyListeners();
      return [];
    });
  }

  void updateTask(Task task) {
    print("${task.id} update");
    repository.updateTask(task);
    notifyListeners();
  }

  void insertTask(Task task) {
    print("${task.id} insert");
    repository.insertTask(task);
    notifyListeners();
  }

  void deleteTask(int id) {
    print("$id delete");
    repository.deleteTask(id);
    notifyListeners();
  }

}