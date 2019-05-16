import 'package:flutter/material.dart';

class ProfileCreatePage extends StatefulWidget {
  @override
  _ProfileCreatePageState createState() => new _ProfileCreatePageState();
}

class _ProfileCreatePageState extends State<ProfileCreatePage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('profile create'),
          backgroundColor: Color(0xFFFFCA28),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
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