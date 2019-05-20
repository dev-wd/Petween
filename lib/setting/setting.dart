import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => new _SettingPageState();
}

class _SettingPageState extends State<SettingPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text('setting'),
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