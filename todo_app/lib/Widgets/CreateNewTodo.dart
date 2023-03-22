import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/TodoListProvider.dart';

class CreateNewTodo extends StatefulWidget {
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();
  DateTime currentDate = DateTime.now();

  @override
  State<StatefulWidget> createState() => _CreateNewTodoState();
}

class _CreateNewTodoState extends State<CreateNewTodo> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: widget.currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050),
        locale: const Locale("vi"));

    if (pickedDate != null && pickedDate != widget.currentDate) {
      setState(() {
        widget.currentDate = pickedDate;
      });
      TimeOfDay? time =
          TimePickerDialog(initialTime: TimeOfDay(hour: 0, minute: 0))
              as TimeOfDay?;
      if (time != null) {
        widget.currentDate.hour;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if ((widget.title.text.length != 0) ||
              (widget.content.text.length != 0))
            IconButton(
                onPressed: () {
                  context.read<TodoListProvider>().add(widget.title.text,
                      widget.content.text, widget.currentDate);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.done))
        ],
        title: Text("Tạo task mới"),
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
                }
            ),
            Text("${DateTime.now().day} tháng ${DateTime.now().month} "
                // "năm ${DateTime.now().year}  "
                "${DateTime.now().hour}:${DateTime.now().minute}  "
                "${widget.title.text.length + widget.content.text.length} ký tự",
              style: TextStyle(fontSize: 14.0,color: Colors.grey),

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
                  text: DateFormat('dd-MM-yyyy').format(widget.currentDate)),
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
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
