import 'dart:ffi';

class Todo {
   String todoId;
   String title;
   String content;
   DateTime dateCreated;
   DateTime estimatedCompletionTime;
   DateTime actualCompletionTime;
   bool status;

   Todo(this.todoId, this.title, this.content, this.dateCreated,
      this.estimatedCompletionTime, this.status,this.actualCompletionTime);
}