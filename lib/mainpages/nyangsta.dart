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
          title: Center(child: Text('N Y A N G S T A R', textAlign: TextAlign.center,),),
          backgroundColor: Color(0xFFFFCA28),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_box,
                color: Color(0xFF5D4037),
              ),
              onPressed: (){
                Navigator.of(context).pushNamed('/edit');
              },
            ),

            IconButton(
              icon: Icon(Icons.settings,
                color: Color(0xFF5D4037),
              ),
              onPressed: (){
                Navigator.of(context).pushNamed('/edit');
              },
            ),
          ],
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