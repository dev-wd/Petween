import 'package:flutter/material.dart';

class AddBoardPage extends StatefulWidget {
  @override
  _AddBoardPageState createState() => new _AddBoardPageState();
}

class _AddBoardPageState extends State<AddBoardPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('addboard'),
          backgroundColor: Color(0xFFFFCA28),
        ),
        body: Center(
          child: IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: (){
                Navigator.of(context).pushNamed('/setting');
              }),
        )
    );
  }
}