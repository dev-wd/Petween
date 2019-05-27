import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodopageState createState() => new _TodopageState();
}

class _TodopageState extends State<TodoPage>{

  List<String> _todoitems = [];

  Widget _TodoList(){
    return ListView.builder(
        itemBuilder: (context, index){
          if(index <_todoitems.length){
            return _buildTodoitem(_todoitems[index]);
          }
        });
  }

  Widget _buildTodoitem(String todoText){
    return ListTile(
      title : Text(todoText, style: TextStyle(fontWeight: FontWeight.bold),)
    );
  }

  _navigatorAdditemScreen(){

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo'),
          backgroundColor: Color(0xFFFFCA28),
        ),
        body:
        _TodoList(),
        floatingActionButton: FloatingActionButton(
          onPressed: _navigatorAdditemScreen,
          tooltip: '할 일 추가',
          child: Icon(Icons.add)
        ),

    );
  }
}