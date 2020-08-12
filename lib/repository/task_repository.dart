
import 'package:simpletodo/data/task.dart';

abstract class TaskRepository {

  Future<List<Task>> loadTasks();

  Future insertTask(Task task);

  Future updateTask(Task task);

  Future deleteTask(int id);

}