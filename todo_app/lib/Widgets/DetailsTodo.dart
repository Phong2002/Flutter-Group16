import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/Todo.dart';
import '../Provider/TodoListProvider.dart';

class DetailsTodo extends StatefulWidget {
  final TextEditingController title;

  final TextEditingController content;

  DateTime expectedCompletion;

  final Todo todo;

  DetailsTodo({Key? key, required this.todo})
      : title = TextEditingController(text: todo.title),
        content = TextEditingController(text: todo.content),
        expectedCompletion = todo.estimatedCompletionTime,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailsTodoState();
}

class _DetailsTodoState extends State<DetailsTodo> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: widget.expectedCompletion,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050),
        locale: const Locale("vi"));

    if (pickedDate != null && pickedDate != widget.expectedCompletion) {
      setState(() {
        widget.expectedCompletion = pickedDate;
      });
      TimeOfDay? time =
          TimePickerDialog(initialTime: TimeOfDay(hour: 0, minute: 0))
              as TimeOfDay?;
      if (time != null) {
        widget.expectedCompletion.hour;
      }
    }
  }

  Container statusTodo(Todo todo) {
    if ((todo.estimatedCompletionTime.compareTo(DateTime.now()) < 0 &&
            !todo.status) &&
        (!DateUtils.isSameDay(todo.estimatedCompletionTime, DateTime.now()))) {
      return Container(
        child: Row(
          children: const [
            Text("Chưa hoàn thành (quá hạn)"),
            Icon(
              Icons.error,
              color: Colors.red,
            )
          ],
        ),
      );
    }else if(((todo.estimatedCompletionTime.compareTo(DateTime.now()) < 0
    &&(!DateUtils.isSameDay(todo.estimatedCompletionTime, todo.actualCompletionTime)))&& todo.status)) {
      return Container(
        child: Row(
          children: const [
            Text("Đã hoàn thành (quá hạn)"),
            Icon(
              Icons.warning,
              color: Colors.yellow,
            )
          ],
        ),
      );
    } else if (((todo.estimatedCompletionTime
        .compareTo(todo.actualCompletionTime) >
        0 ||
        (DateUtils.isSameDay(
            todo.estimatedCompletionTime, todo.actualCompletionTime))) &&
        todo.status))  {
      return Container(
        child: Row(
          children: const [
            Text("Đã hoàn thành "),
            Icon(
              Icons.done,
              color: Colors.green,
            )
          ],
        ),
      );
    }
    return Container(
      child: Row(
        children: const [
          Text("Chưa hoàn thành "),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if ((widget.title.text != widget.todo.title) ||
              (widget.content.text != widget.todo.content) ||
              (widget.expectedCompletion
                      .compareTo(widget.todo.estimatedCompletionTime) !=
                  0))
            IconButton(
                onPressed: () {
                  setState(() {
                    widget.todo.title = widget.title.text;
                    widget.todo.content = widget.content.text;
                    widget.todo.estimatedCompletionTime =
                        widget.expectedCompletion;
                  });
                  context.read<TodoListProvider>().update(widget.todo);
                },
                icon: Icon(Icons.done))
          else
            PopupMenuButton(itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("Xóa"),
                ),
                if (widget.todo.status)
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("Chưa hoàn thành"),
                  ),
                if (!widget.todo.status)
                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text("Hoàn thành"),
                  ),
              ];
            }, onSelected: (value) {
              if (value == 0) {
                Provider.of<TodoListProvider>(context, listen: false)
                    .remove(widget.todo.todoId);
                Navigator.pop(context);
              } else if (value == 1) {
                setState(() {
                  widget.todo.status = false;
                });
                Provider.of<TodoListProvider>(context, listen: false)
                    .update(widget.todo);
              } else if (value == 2) {
                setState(() {
                  widget.todo.status = true;
                  widget.todo.actualCompletionTime = DateTime.now();
                });
                Provider.of<TodoListProvider>(context, listen: false)
                    .update(widget.todo);
              }
            }),
        ],
        title: Text("Chi tiết công việc"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                style: TextStyle(fontSize: 27.0),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Tiêu đề',
                ),
                maxLines: 5,
                minLines: 1,
                controller: widget.title,
                onChanged: (e) {
                  setState(() {
                    widget.title.value = TextEditingValue(
                      text: e,
                      selection: TextSelection.fromPosition(
                        TextPosition(offset: e.length),
                      ),
                    );
                  });
                }),
            Text(
              "${DateTime.now().day} tháng ${DateTime.now().month} "
              // "năm ${DateTime.now().year}  "
              "${DateTime.now().hour}:${DateTime.now().minute}  "
              "${widget.title.text.length + widget.content.text.length} ký tự",
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            TextFormField(
              style: TextStyle(fontSize: 18.0),
              onTap: () {
                _selectDate(context);
              },
              readOnly: true,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Ngày dự kiến hoàn thành ',
              ),
              controller: TextEditingController(
                  text: DateFormat('dd-MM-yyyy')
                      .format(widget.expectedCompletion)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 9.0, 0, 9.0),
              child: Row(
                children: [
                  Text("Trạng thái : "),
                  statusTodo(widget.todo)
                ],
              ),
            ),
            Expanded(
              child: TextField(
                  style: TextStyle(fontSize: 18.0),
                  minLines: 1,
                  controller: widget.content,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Nội dung",
                  ),
                  onChanged: (e) {
                    setState(() {
                      widget.content.value = TextEditingValue(
                        text: e,
                        selection: TextSelection.fromPosition(
                          TextPosition(offset: e.length),
                        ),
                      );
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
