import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<SignInPage>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text('P E T W E E N', style: TextStyle(color: Colors.black),),
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
                Navigator.of(context).pushNamed('/login');
              }),
        ),
      backgroundColor: Color(0xFFFFCA28),
    );
  }
}