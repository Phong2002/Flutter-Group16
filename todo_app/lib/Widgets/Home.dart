import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Widgets/CreateNewTodo.dart';

import '../Provider/TodoListProvider.dart';
import 'Todo.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSelect = false;

  bool isSearch = false;

  var search = TextEditingController();

  String TitleAppBar(String number) {
    String title = '';

    if (isSelect) {
      if (number == "0") {
        title = "Chọn mục";
      } else {
        title = "Đã chọn $number mục";
      }
    } else {
      title = "Quản lý công việc";
    }
    return title;
  }

  Future<void> _showDialog(String title,String content,Function callback) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Có',style: TextStyle(fontSize: 18.0),),
              onPressed: () {
                callback();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Không',style: TextStyle(fontSize: 18.0),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          actions: [
            isSelect
                ? IconButton(
                    onPressed: () {
                      context.read<TodoListProvider>().clearSelected();
                      setState(() {
                        isSelect = false;
                      });
                    },
                    icon: Icon(Icons.cancel_outlined, size: 30.0))
                : isSearch
                    ? IconButton(
                        onPressed: () {
                          context.read<TodoListProvider>().clearSelected();
                          setState(() {
                            search = TextEditingController();
                            isSearch = false;
                          });
                        },
                        icon: Icon(Icons.cancel_outlined, size: 30.0))
                    : IconButton(
                        onPressed: () {
                          context.read<TodoListProvider>().clearSelected();
                          setState(() {
                            isSearch = true;
                          });
                        },
                        icon: Icon(Icons.search, size: 30.0))
          ],
          centerTitle: true,
          title: !isSearch
              ? Text(TitleAppBar(context
                  .watch<TodoListProvider>()
                  .listSelected
                  .length
                  .toString()))
              : Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: TextField(
                      controller: search,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Tìm kiếm',
                        border: InputBorder.none,
                      ),
                      onChanged: (e) {
                        setState(() {
                          search.value = TextEditingValue(
                            text: e,
                            selection: TextSelection.fromPosition(
                              TextPosition(offset: e.length),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              ...context
                  .watch<TodoListProvider>()
                  .displayTodoList(search.text)
                  .map((e) => TodoWidgets(
                        todo: e,
                        isSelect: isSelect,
                        openSelect: () => {
                          setState(() => {isSelect = true})
                        },
                      ))
            ],
          ),
        ),
        backgroundColor: Colors.grey[200],
        floatingActionButton: !isSelect
            ? FloatingActionButton(
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return CreateNewTodo();
                    },
                  ))
                },
                tooltip: 'Tạo mới',
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: isSelect ? 80.0 : 0,
          child: BottomAppBar(
            elevation: isSelect ? null : 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  tooltip: 'Xóa',
                  icon: const Icon(CupertinoIcons.trash),
                  onPressed: () {

                    _showDialog("Xóa công việc"
                        ,"Bạn có chắc chắn muốn xóa ${Provider.of<TodoListProvider>(context, listen: false).listSelected.length} mục không",
                        ()=>{Provider.of<TodoListProvider>(context, listen: false).removeTodosSelected()}
                    );
                  },
                ),
                IconButton(
                  tooltip: 'Hoàn thành',
                  icon: const Icon(Icons.done),
                  onPressed: () {
                    context.read<TodoListProvider>().selectedComplete();
                  },
                ),
                IconButton(
                  tooltip: 'Chọn tất cả',
                  icon: const Icon(Icons.checklist),
                  color: (context
                              .watch<TodoListProvider>()
                              .displayTodoList(search.text)
                              .length ==
                          context.watch<TodoListProvider>().listSelected.length)
                      ? Colors.lightBlue
                      : null,
                  onPressed: () {
                    if (Provider.of<TodoListProvider>(context, listen: false)
                            .listSelected
                            .length ==
                        Provider.of<TodoListProvider>(context, listen: false)
                            .displayTodoList(search.text)
                            .length) {
                      context.read<TodoListProvider>().clearSelected();
                    } else {
                      context.read<TodoListProvider>().selectAll(search.text);
                    }
                  },
                ),
              ],
            ),
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
