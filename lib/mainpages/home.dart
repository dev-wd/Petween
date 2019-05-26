import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/examplemanda.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left:70.0,top: 12),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("D+140",style: TextStyle(color: Colors.black,fontSize: 15),),
                      Icon(Icons.favorite,color: Colors.redAccent,)
                    ],
                  ),
                  Text("with manda" , style: TextStyle(color: Colors.black,fontSize: 15),)
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Color(0xFFFFCA28),
                size: 40,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/catchoice');
              },
            ),
            actions: <Widget>[
              // action button
              IconButton(
                icon: Icon(
                  Icons.alarm,
                  color: Color(0xFFFFCA28),
                  size: 40,
                ),
                onPressed: () {},
              ),
              // action button
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Color(0xFFFFCA28),
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/setting');
                  },
                ),
              ),
            ],
          ),
          body: Column(
            children: <Widget>[
              Container(
                color: Colors.transparent,
              ),
            ],
          ),
        )
      ],
    );
  }
}
