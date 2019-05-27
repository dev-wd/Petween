import 'package:flutter/material.dart';
import 'dart:async';

class PreloginPage extends StatefulWidget {
  @override
  _PreloginPageState createState() => new _PreloginPageState();
}

class _PreloginPageState extends State<PreloginPage>{

  Future<Timer> startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage(){
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox.fromSize(size: MediaQuery.of(context).size / 4.0),

            Image.asset('assets/catfoot.png', width: 300, height: 200,),

            SizedBox.fromSize(size: MediaQuery.of(context).size / 90),

            Text(
              'P E T W E E N',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFFFCA28),
    );
  }
}
