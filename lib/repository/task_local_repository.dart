
import 'package:flutter/material.dart';
import 'package:simpletodo/data/task.dart';
import 'package:simpletodo/db/database_helper.dart';
import 'package:simpletodo/repository/task_repository.dart';

class TaskLocalRepository implements TaskRepository {

  final DataBaseHelper _dataBaseHelper = DataBaseHelper();

  @override
  Future<List<Task>> loadTasks() async {
    return await _dataBaseHelper.getAllData();
  }

  @override
  Future insertTask(Task task)  async {
    return await _dataBaseHelper.insertData(task);
  }

  @override
  Future updateTask(Task task) async {
    return await _dataBaseHelper.updateData(task);
  }

  @override
  Future deleteTask(int id) async {
    return await _dataBaseHelper.deleteData(id);
  }

}