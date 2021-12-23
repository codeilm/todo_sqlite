import 'package:todo_sqlite/db_helper.dart';
import 'package:todo_sqlite/todo.dart';

class TodoModel {
  DBHelper dbHelper = DBHelper.instance;

  Future<List<Todo>> getTodos() async {
    List todos = await dbHelper.queryAll();
    return todos.map((todo) => Todo.fromJSON(todo)).toList();
    // await Future.delayed(Duration(seconds: 1));
    // return [
    //   Todo(id: 1, title: 'Home work', description: 'Maths homework'),
    //   Todo(id: 2, title: 'Party', description: 'Birth day'),
    //   Todo(id: 3, title: 'Shopping', description: 'Eid shopping'),
    // ];
  }

  Future<void> insert(Todo todo) async {
    await dbHelper.insert(todo.toJSON());
  }

  Future<void> update(Todo todo) async {
    await dbHelper.update(todo.toJSON());
  }

  Future<void> delete(Todo todo) async {
    await dbHelper.delete(todo.id);
  }
}
