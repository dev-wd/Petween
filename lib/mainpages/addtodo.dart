import 'package:flutter/material.dart';
import 'package:petween/mainpages/todo.dart';


class AddTodoPage extends StatefulWidget {
  @override
  _AddTodoPageState createState() => new _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Add To do'),
          backgroundColor: Color(0xFFFFCA28),
        ),
        body: TextField(
          autofocus: true,
          onSubmitted: (val){
            Navigator.of(context).pop({'item':val});
          },
        )
    );
  }
}