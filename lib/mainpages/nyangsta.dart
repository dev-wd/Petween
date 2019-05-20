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
          title: Text('N Y A N G S T A R'),
          backgroundColor: Color(0xFFFFCA28),
          leading: IconButton(
            icon: Icon(Icons.settings,
            color: Colors.black,
            ),
          ),
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