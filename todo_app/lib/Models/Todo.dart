import 'dart:ffi';

class Todo {
   String todoId;
   String title;
   String content;
   DateTime dateCreated;
   DateTime expectedCompletion;
   bool status;

   Todo(this.todoId, this.title, this.content, this.dateCreated,
      this.expectedCompletion, this.status);
}