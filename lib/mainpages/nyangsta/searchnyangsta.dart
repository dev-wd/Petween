import 'package:flutter/material.dart';

class SearchNyangPage extends StatefulWidget {
  @override
  _SearchNyangPageState createState() => new _SearchNyangPageState();
}

class _SearchNyangPageState extends State<SearchNyangPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
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