import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petween/tab.dart';
import 'package:petween/model/db.dart' as db;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

DateTime curDate = DateTime.now();
bool isclick = false;


class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    // TODO: implement initState

     DateTime curDate = DateTime.now();
     print(curDate.hour);
  }

  Widget _buildbody(){
    return StreamBuilder(
        stream: Firestore.instance.collection('pet').document(
            tabrecord.petname + tabrecord.uid)
            .collection('todo')
            .where('isdone', isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, i) =>
                    _TodoList(context,snapshot.data.documents[i])
            );
          } else {
            return Container(
                child: Center(
                  child: Text("Loading.."),
                ));
          }
        });
  }



  Widget _TodoList(BuildContext context, DocumentSnapshot data){
    final record = db.todo.fromSnapshot(data);
    print(record.work);
    if(!record.isdone && record.isdue) {
      int cur = curDate.hour * 60 + curDate.minute;
      int due = int.parse(record.duehour) * 60 + int.parse(record.duemin);
      int dif = due - cur;
      int curmonth = curDate.month;
      int curday = curDate.day;

      print(dif);

      if(curmonth == int.parse(record.duemonth) && (int.parse(record.dueday)-curday)<=1 && 0<dif && dif < 720){
        return Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(record.work, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          ),
        );
      }
      else{
        return SizedBox(height: 0.0001,);
      }
    }
    else{
      return SizedBox(height: 0.0001,);
    }
  }



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
                  Icons.account_circle,
                  color: Color(0xFFFFCA28),
                  size: 40,
                ),
                onPressed: () {Navigator.of(context).pushReplacementNamed('/edit');},
              ),
              IconButton(
                icon: Icon(
                  Icons.alarm,
                  color: Color(0xFFFFCA28),
                  size: 40,
                ),
                onPressed: () {
                  setState(() {
                    isclick=!isclick;
                  });
                }
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
          body: isclick?
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                    Container(
                      constraints: BoxConstraints(
                          maxHeight: 300.0,
                          maxWidth: 421.0,
                          minWidth: 421.0,
                          minHeight: 30.0
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: new BorderRadius.only(
                            topLeft:  const  Radius.circular(40.0),
                            topRight: const  Radius.circular(40.0)),

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.check, color: Colors.redAccent,),
                          Text(' 12 시 간 남 았 어 요 ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.redAccent),textAlign: TextAlign.center,),
                          Icon(Icons.check, color: Colors.redAccent,),
                        ],
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.only(
                          bottomLeft:  const  Radius.circular(40.0),
                          bottomRight: const  Radius.circular(40.0)),
                      color: Colors.white70,
                    ),
                    child: _buildbody(),
                  ),
                  SizedBox(height: 10,)
                ],
              ) : Container(),
        ),
      ],
    );
  }
}
