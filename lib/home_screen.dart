import 'package:flutter/material.dart';
import 'package:todo_sqlite/todo.dart';
import 'package:todo_sqlite/todo_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoModel todoModel = TodoModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO using SQLite'),
      ),
      body: FutureBuilder(
        future: todoModel.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return Center(
                child: Text('There is no todo'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Todo todo = snapshot.data[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      todo.title,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      todo.description,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          todoModel.delete(todo);
                        });
                      },
                    ),
                    onTap: () {
                      myDialog(todo: todo, isUpdate: true);
                    },
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          myDialog(todo: Todo());
        },
      ),
    );
  }

  myDialog({Todo todo, bool isUpdate = false}) {
    showDialog(
        context: context,
        builder: (context) {
          var titleController =
              TextEditingController(text: isUpdate ? todo.title : '');
          var descriptionController =
              TextEditingController(text: isUpdate ? todo.description : '');
          return AlertDialog(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Title'),
                  onChanged: (value) {
                    todo.title = value;
                  },
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: 'Description'),
                  onChanged: (value) {
                    todo.description = value;
                  },
                ),
              ],
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (isUpdate) {
                      todoModel.update(todo);
                    } else {
                      todoModel.insert(todo);
                    }

                    Navigator.pop(context);
                  },
                  child: Text(isUpdate ? 'Update' : 'Save'),
                ),
              ],
            ),
          );
        }).then((value) => setState(() {}));
  }
}
