import 'package:simpletodo/data/db/database_helper.dart';
import 'package:simpletodo/data/model/task.dart';
import 'package:simpletodo/data/repository/task_repository.dart';

class TaskLocalRepository implements TaskRepository {
  final DataBaseHelper _dataBaseHelper = DataBaseHelper();

  @override
  loadTasks() async => await _dataBaseHelper.getAllData();

  @override
  insertTask(Task task) async => await _dataBaseHelper.insertData(task);

  @override
  updateTask(Task task) async => await _dataBaseHelper.updateData(task);

  @override
  deleteTask(int id) async => await _dataBaseHelper.deleteData(id);
}
