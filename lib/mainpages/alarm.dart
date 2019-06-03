import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petween/model/db.dart' as db;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petween/tab.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => new _AlarmPageState();
}

FirebaseUser mCurrentUser;


List<dynamic> _list = [];

List<dynamic> al = [];
DateTime curDate = DateTime.now();

class _AlarmPageState extends State<AlarmPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final record = db.Isdue;

  _getCurrentUser() async {
    mCurrentUser = await FirebaseAuth.instance.currentUser();

  }

  Widget _TodoList(BuildContext context, DocumentSnapshot data){
    final record = db.Isdue.fromSnapshot(data);
    print(record.work);
    int cur = curDate.hour * 60 + curDate.minute ;
    int due = int.parse(record.duehour)*60 + int.parse(record.duemin);
    int dif = due - cur;
    int curmonth = curDate.month;
    int curday = curDate.day;

    print(dif);
    if(curmonth == int.parse(record.duemonth) && (int.parse(record.dueday)-curday)<=1 && 0<dif && dif < 1800){
      return Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Text(record.work),
      );
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    _list = [];
    print('현재시간');
    print(curDate.hour);
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentUser();
    return Scaffold(
      backgroundColor: Colors.white70,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('알 람'),
        backgroundColor: Color(0xFFFFCA28),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: Firestore.instance.collection('pet').document(
                    tabrecord.petname + tabrecord.uid)
                    .collection('Isdue')
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
                })
          ),
        ],
      ),
    );
  }
}
