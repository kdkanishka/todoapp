
import 'package:flutter/material.dart';
import 'package:todoapp/dto/todoentry.dart';

import 'apiclient/todoapiclient.dart';

class ToDoItem extends StatefulWidget {
  final ToDoEntry toDoEntry;
  final ToDoApiClient toDoApiClient;

  const ToDoItem({Key? key, required this.toDoEntry, required this.toDoApiClient}) : super(key: key);

  @override
  _ToDoItemState createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  String _text = "";
  bool isComplete = false;
  
  Future<ToDoEntry>? toDoEntryFut;

  @override
  void initState() {
    super.initState();
    isComplete = widget.toDoEntry.done;
    _text = widget.toDoEntry.text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(_text),
          leading: Checkbox(
            value: isComplete,
            onChanged: (value)  {
              setState(() {
                isComplete= value!;
                widget.toDoEntry.done=isComplete;
                toDoEntryFut = widget.toDoApiClient.update( widget.toDoEntry);
              });
            },
          ),
        ),
        const SizedBox(height: 8,),
        toDoEntryFut != null ? FutureBuilder(builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: LinearProgressIndicator(),
              );
            case ConnectionState.done:
              return Container();
          }
        },
        future: toDoEntryFut!,
        ):Container()
      ],
    );
  }
}
