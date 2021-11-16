import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/apiclient/todoapiclient.dart';
import 'package:todoapp/dto/todoentry.dart';
import 'package:todoapp/todoitem.dart';

class TodoAppWidget extends StatefulWidget {
  const TodoAppWidget({Key? key}) : super(key: key);

  @override
  _TodoAppWidgetState createState() => _TodoAppWidgetState();
}

class _TodoAppWidgetState extends State<TodoAppWidget> {
  ToDoApiClient toDoApiClient =
      ToDoApiClient(Dio(), baseUrl: "http://todoapi.com");

  late Future<List<ToDoEntry>> todoListFut;
  late List<ToDoEntry> todoList;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    setState(() {
      todoListFut = toDoApiClient.getAll();
    });
    todoList = await todoListFut;
  }

  void _add(ToDoEntry toDoEntry) async {
    toDoApiClient.create(toDoEntry);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("TODO App"),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _load(),
            ),
          ],
        ),
        body: _createFutureBuilder(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _displayTextInputDialog(context);
          },
          tooltip: 'Add new TODO',
          child: const Icon(Icons.add),
        ));
  }

  Widget _createFutureBuilder() {
    return Center(
      child: Card(
        elevation: 32,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.70,
          child: FutureBuilder(
            future: todoListFut,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  return _createList();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _createList() {
    return ListView.separated(
      itemBuilder: (context, index) {
        final todoEntry = todoList[index];
        return ToDoItem(
          toDoEntry: todoEntry,
          toDoApiClient: toDoApiClient,
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: todoList.length,
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('TODO item'),
              content: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(hintText: "Your todo here"),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('ADD'),
                  onPressed: () {
                    setState(() {
                      final text = _textEditingController.text;
                      _textEditingController.clear();
                      final todo = ToDoEntry(-1, text, false);
                      _add(todo);
                      Navigator.pop(context);
                    });
                  },
                ),
              ]);
        });
  }
}
