import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:getx_todo_app/controllers/TodoController.dart';
import 'package:getx_todo_app/models/Todo.dart';

class TodoScreen extends StatelessWidget {
  final TodoController todoController = Get.find();
  final int index;

  TodoScreen({this.index});

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (!this.index.isNull) {
      text = todoController.todos[index].text;
    }
    TextEditingController textEditingController =
        TextEditingController(text: text);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            todoController.todos != null ? 'Edit Todo' : 'New Todo',
            style: TextStyle(fontFamily: 'Spartan', fontSize: 24.0),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  maxLines: 5,
                  controller: textEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Enter todo here',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Spartan',
                        fontSize: 14.0),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )),
              new Padding(padding: EdgeInsets.only(top: 10)),
              RaisedButton(
                child: Text((this.index.isNull) ? 'ADD' : 'UPDATE',
                    style: TextStyle(fontFamily: 'Spartan', fontSize: 18.0)),
                color: Colors.pink,
                onPressed: () {
                  if (this.index.isNull) {
                    todoController.todos
                        .add(Todo(text: textEditingController.text));
                  } else {
                    var editing = todoController.todos[index];
                    editing.text = textEditingController.text;
                    todoController.todos[index] = editing;
                  }
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
