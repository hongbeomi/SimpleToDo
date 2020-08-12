import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simpletodo/data/task.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  final String tableName = "TASK";

  DataBaseHelper._();

  static final DataBaseHelper _db = DataBaseHelper._();

  factory DataBaseHelper() => _db;

  static Database _dataBase;

  Future<Database> get database async {
    if (_dataBase != null) return _dataBase;
    _dataBase = await initDB();
    return _dataBase;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return openDatabase(join(documentsDirectory.path, 'task_database.db'),
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  _onCreate(Database db, int newVersion) {
    return db.execute(
      "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, title TEXT, description TEXT, isFinish INTEGER)",
    );
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS $tableName");
    _onCreate(db, newVersion);
  }

  Future<List<Task>> getAllData() async {
    var res = await ((await database).query(tableName));
    List<Task> list = res.isNotEmpty
        ? res.map((c) => Task(
                id: c['id'],
                title: c['title'],
                description: c['description'],
                isFinish: c['isFinish']))
            .toList()
        : [];
    return list;
  }

  insertData(Task task) async {
    return await ((await database).insert(tableName, task.toMap()));
  }

  updateData(Task task) async {
    return await ((await database).update(tableName, task.toMap(), where : "id = ?", whereArgs: [task.id]));
  }

  deleteData(int id) async {
    return await ((await database).delete(tableName, where: "id = ?", whereArgs: [id]));
  }
}
