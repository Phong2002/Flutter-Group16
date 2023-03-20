import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../Models/Todo.dart';

class TodoListProvider extends ChangeNotifier{

  late List<Todo> _todoList = [];

  void add(Todo todo){
    todo.todoId = Uuid().v1();
    _todoList.add(todo);
    notifyListeners();
  }

  void remove(String id){
    List<Todo> newTodoList = _todoList.where((todo) => todo.todoId!=id).toList();
    _todoList=newTodoList;
    notifyListeners();
  }

  void removeMany(List<String> ids){
    List<Todo> newTodoList = _todoList.where((todo) => ids.contains(todo.todoId)).toList();
    _todoList=newTodoList;
    notifyListeners();
  }

  void update(Todo todo){
    _todoList[_todoList.indexWhere((element) => element.todoId == todo.todoId)] = todo;
    notifyListeners();
  }



}