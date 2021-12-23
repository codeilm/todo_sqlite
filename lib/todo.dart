import 'package:flutter/material.dart';
import 'package:todo_sqlite/db_helper.dart';

class Todo {
  int id;
  String title;
  String description;
  Todo({this.id, this.title, this.description});

  Todo.fromJSON(Map<String, dynamic> todo) {
    this.id = todo[DBHelper.columnID];
    this.title = todo[DBHelper.columnTitle];
    this.description = todo[DBHelper.columnDescription];
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> todoJSON = {};
    todoJSON[DBHelper.columnID] = id;
    todoJSON[DBHelper.columnTitle] = title;
    todoJSON[DBHelper.columnDescription] = description;
    return todoJSON;
  }
}
