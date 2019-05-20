import 'package:flutter/material.dart';

class QNAPage extends StatefulWidget {
  @override
  _QNAPageState createState() => new _QNAPageState();
}

class _QNAPageState extends State<QNAPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('qna'),
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