import 'package:flutter/material.dart';

class AddPetPage extends StatefulWidget {
  @override
  _AddPetPageState createState() => new _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text('addpet'),
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