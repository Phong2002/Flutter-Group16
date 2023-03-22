import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../Models/Todo.dart';

class TodoListProvider extends ChangeNotifier {
  List<Todo> _todoList = [];
  List<String> listSelected = [];

  List<Todo> displayTodoList(String search) {
    List<Todo> todoList =
        _todoList.where((todo) => todo.title.contains(search)).toList().reversed.toList();
    return todoList;
  }

  void clearSelected() {
    listSelected = [];
    notifyListeners();
  }

  bool isSelected(String todoId) {
    return listSelected.contains(todoId);
  }

  void onChangeSelect(String todoId) {
    if (listSelected.contains(todoId)) {
      listSelected.remove(todoId);
    } else {
      listSelected.add(todoId);
    }
    notifyListeners();
  }

  void removeTodosSelected() {
    removeMany(listSelected);
    notifyListeners();
  }

  void selectAll(String search) {
    List<Todo> todoLists =
        _todoList.where((todo) => todo.title.contains(search)).toList();
    listSelected = [];
    todoLists.forEach((todo) {
      listSelected.add(todo.todoId);
    });
    notifyListeners();
  }

  void selectedComplete() {
    listSelected.forEach((todoIdSelected) {
      todoList[todoList
              .indexWhere((element) => element.todoId == todoIdSelected)]
          .status = true;
    });
    notifyListeners();
  }

  void add(String title, String content, DateTime expectedCompletion) {
    String todoId = const Uuid().v1();
    DateTime dateCreated = DateTime.now();
    bool status = false;
    Todo todo =
        Todo(todoId, title, content, dateCreated, expectedCompletion, status);
    _todoList.add(todo);
    notifyListeners();
  }

  void remove(String id) {
    List<Todo> newTodoList =
        _todoList.where((todo) => todo.todoId != id).toList();
    _todoList = newTodoList;
    notifyListeners();
  }

  void removeMany(List<String> ids) {
    List<Todo> newTodoList =
        _todoList.where((todo) => !ids.contains(todo.todoId)).toList();
    _todoList = newTodoList;
    clearSelected();
    notifyListeners();
  }

  void update(Todo todo) {
    _todoList[_todoList
        .indexWhere((element) => element.todoId == todo.todoId)] = todo;
    notifyListeners();
  }

  List<Todo> get todoList => _todoList;

  set todoList(List<Todo> value) {
    _todoList = value;
  }
}
