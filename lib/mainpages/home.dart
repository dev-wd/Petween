import 'package:flutter/material.dart';
import 'package:petween/tab.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final meetday2 = DateTime(int.parse(tabrecord.meetyear),
        int.parse(tabrecord.meetmonth), int.parse(tabrecord.meetday));
    final date2 = DateTime.now();
    final difference = date2.difference(meetday2).inDays;

    return Stack(
      children: <Widget>[
        new Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                 tabrecord.image,
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
                      Text("D+"+difference.toString(),style: TextStyle(color: Colors.black,fontSize: 15),),
                      Icon(Icons.favorite,color: Colors.redAccent,)
                    ],
                  ),
                  Text("with "+ tabrecord.petname , style: TextStyle(color: Colors.black,fontSize: 15),)
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
