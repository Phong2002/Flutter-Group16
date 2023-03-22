import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/Todo.dart';
import '../Provider/TodoListProvider.dart';


class DetailsTodo extends StatefulWidget {
  final TextEditingController title ;
  final TextEditingController content ;
  DateTime expectedCompletion ;
  final Todo todo  ;
  DetailsTodo({ Key? key, required this.todo}) :
        title=TextEditingController(text:todo.title),
        content=TextEditingController(text:todo.content),
        expectedCompletion=todo.expectedCompletion,
        super(key: key);

  @override
  State<StatefulWidget> createState() =>_DetailsTodoState();
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


   @override
   Widget build(BuildContext context) {
     print(widget.todo.title);
     return Scaffold(
       appBar: AppBar(
         actions: [
           if ((widget.title.text != widget.todo.title) ||
               (widget.content.text != widget.todo.content) ||
               (widget.expectedCompletion.compareTo(widget.todo.expectedCompletion)!=0
               )
           )
             IconButton(
                 onPressed: () {
                   setState(() {
                     widget.todo.title = widget.title.text;
                     widget.todo.content = widget.content.text;
                     widget.todo.expectedCompletion = widget.expectedCompletion;
                   });
                   context.read<TodoListProvider>().update(widget.todo);
                 },
                 icon: Icon(Icons.done))
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
                 }
             ),
             Text("${DateTime
                 .now()
                 .day} tháng ${DateTime
                 .now()
                 .month} "
             // "năm ${DateTime.now().year}  "
                 "${DateTime
                 .now()
                 .hour}:${DateTime
                 .now()
                 .minute}  "
                 "${widget.title.text.length +
                 widget.content.text.length} ký tự",
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
                   text: DateFormat('dd-MM-yyyy').format(widget.expectedCompletion)),
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
