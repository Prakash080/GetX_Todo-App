import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:getx_todo_app/controllers/TodoController.dart';
import 'package:getx_todo_app/screens/TodoScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    final TodoController todoController = Get.put(TodoController());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Todo List',
            style: TextStyle(fontFamily: 'Spartan', fontSize: 28.0),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.pink,
          onPressed: () {
            Get.to(TodoScreen());
          },
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Obx(() => ListView.separated(
              itemBuilder: (context, index) => ListTile(
                    title: Text(todoController.todos[index].text,
                        style: (todoController.todos[index].done)
                            ? TextStyle(
                                color: Colors.pink,
                                decoration: TextDecoration.lineThrough,
                                fontFamily: 'Spartan',
                                fontSize: 18.0,
                              )
                            : TextStyle(
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                                fontFamily: 'Spartan',
                                fontSize: 18.0,
                              )),
                    leading: Checkbox(
                      activeColor: Colors.deepPurple,
                      value: todoController.todos[index].done,
                      onChanged: (v) {
                        var changed = todoController.todos[index];
                        changed.done = v;
                        todoController.todos[index] = changed;
                      },
                    ),
                    subtitle:
                        Text('Created on:${now.day}/${now.month}/${now.year}'),
                    trailing: IconButton(
                        icon: Icon(todoController.todos[index].done
                            ? Icons.delete_forever
                            : Icons.edit),
                        onPressed: () {
                          if (todoController.todos[index].done) {
                            var removed = todoController.todos[index];
                            todoController.todos.removeAt(index);
                            Get.snackbar('Todo removed',
                                'The todo "${removed.text}" was successfully removed.',
                                mainButton: FlatButton(
                                  child: Text('Undo'),
                                  onPressed: () {
                                    if (removed.isNull) {
                                      return;
                                    }
                                    todoController.todos.insert(index, removed);
                                    removed = null;
                                    if (Get.isSnackbarOpen) {
                                      Get.back();
                                    }
                                  },
                                ));
                          } else {
                            Get.to(TodoScreen(
                              index: index,
                            ));
                          }
                        }),
                  ),
              separatorBuilder: (_, __) => Divider(),
              itemCount: todoController.todos.length)),
        ));
  }
}
