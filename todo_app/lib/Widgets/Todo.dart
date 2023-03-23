import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/TodoListProvider.dart';

import '../Models/Todo.dart';
import 'DetailsTodo.dart';

class TodoWidgets extends StatefulWidget {
  final Todo todo;

  final bool isSelect;

  final Function openSelect;

  TodoWidgets(
      {Key? key,
      required this.todo,
      required this.isSelect,
      required this.openSelect})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodoWidgetsState();
}

class _TodoWidgetsState extends State<TodoWidgets> {
  Color ColorTodo(Todo todo) {
    if ((todo.estimatedCompletionTime.compareTo(DateTime.now()) < 0 &&
            !todo.status) &&
        (!DateUtils.isSameDay(todo.estimatedCompletionTime, DateTime.now()))) {
      return Color.fromARGB(255, 255, 151, 151);
    } else if (((todo.estimatedCompletionTime.compareTo(DateTime.now()) < 0 &&
            (!DateUtils.isSameDay(
                todo.estimatedCompletionTime, todo.actualCompletionTime))) &&
        todo.status)) {
      return Color.fromARGB(255, 255, 235, 81);
    } else if (((todo.estimatedCompletionTime
                    .compareTo(todo.actualCompletionTime) >
                0 ||
            (DateUtils.isSameDay(
                todo.estimatedCompletionTime, todo.actualCompletionTime))) &&
        todo.status)) {
      return Color.fromARGB(255, 166, 255, 188);
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        child: Material(
          color: ColorTodo(widget.todo),
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(10),
                            //apply padding to all four sides
                            child: Text(
                              widget.todo.title,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0),
                            )),
                        Padding(
                          padding: EdgeInsets.all(10),
                          //apply padding to all four sides
                          child: Text(
                            widget.todo.content,
                            maxLines: 3,
                            softWrap: true,
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            //apply padding to all four sides
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.todo.status
                                    ? "Hoàn thành"
                                    : "Chưa hoàn thành"),
                                Text(
                                  DateFormat('dd-MM-yyyy').format(
                                      widget.todo.estimatedCompletionTime),
                                  style: TextStyle(
                                      decoration: (widget.todo
                                                      .estimatedCompletionTime
                                                      .compareTo(
                                                          DateTime.now()) <
                                                  0 &&
                                              (!DateUtils.isSameDay(
                                                  widget.todo
                                                      .estimatedCompletionTime,
                                                  DateTime.now())))
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  if (widget.isSelect)
                    Checkbox(
                        shape: CircleBorder(),
                        value: context
                            .watch<TodoListProvider>()
                            .isSelected(widget.todo.todoId),
                        onChanged: (e) => {
                              context
                                  .read<TodoListProvider>()
                                  .onChangeSelect(widget.todo.todoId)
                            })
                ],
              ),
            ),
            onTap: () => {
              if (widget.isSelect)
                {
                  context
                      .read<TodoListProvider>()
                      .onChangeSelect(widget.todo.todoId)
                }
              else
                {
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return DetailsTodo(todo: widget.todo);
                    },
                  ))
                }
            },
            onLongPress: () => {widget.openSelect()},
          ),
        ));
  }
}
