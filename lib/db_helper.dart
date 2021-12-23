import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static String _databaseName = 'records.db';
  static int _databaseVersion = 1;
  static String _tableName = 'todo';
  static String columnID = 'id';
  static String columnTitle = 'title';
  static String columnDescription = 'description';

  DBHelper._privateConstructor();

  static DBHelper instance = DBHelper._privateConstructor();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    return _database = await _initializeDB();
  }

  Future<Database> _initializeDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + '/' + _databaseName;
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _oncreate);
  }

  Future<void> _oncreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tableName (
    $columnID INTEGER PRIMARY KEY,
    $columnTitle TEXT NOT NULL,
    $columnDescription TEXT NOT NULL
    )    
    ''');
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    print('running');
    final db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> insert(Map<String, dynamic> todo) async {
    final db = await instance.database;
    return await db.insert(_tableName, todo);
  }

  Future<int> update(Map<String, dynamic> todo) async {
    final db = await instance.database;
    return await db.update(_tableName, todo,
        where: '$columnID = ?', whereArgs: [todo[columnID]]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(_tableName, where: '$columnID = ?', whereArgs: [id]);
  }
}
