import 'package:flutter/material.dart';

class NyangGaeBuPage extends StatefulWidget {
  @override
  _NyangGaeBuPageState createState() => new _NyangGaeBuPageState();
}

class _NyangGaeBuPageState extends State<NyangGaeBuPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('nyanggaebu'),
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