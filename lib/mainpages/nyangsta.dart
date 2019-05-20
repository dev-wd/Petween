import 'package:flutter/material.dart';

class NyangStaPage extends StatefulWidget {
  @override
  _NyangStaPageState createState() => new _NyangStaPageState();
}

class _NyangStaPageState extends State<NyangStaPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('nyangsta'),
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