import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petween/model/db.dart' as db;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petween/tab.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => new _TodoPageState();
}

String accountStatus = '******';
FirebaseUser mCurrentUser;
FirebaseAuth _auth;
bool liked = false;
DateTime now = DateTime.now();
DateTime currentTime = new DateTime(now.hour, now.minute);
List<String> _list = [];

class _TodoPageState extends State<TodoPage> {
  db.db record;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _getCurrentUser() async {
    mCurrentUser = await FirebaseAuth.instance.currentUser();

  }

  void _showDialog(DocumentSnapshot data) {

    final record = db.todo.fromSnapshot(data);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("할 일 완 료"),
          content: new Text("삭제하시겠습니까?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("확인"),
              onPressed: () {
                record.reference.delete();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("취소"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _TodoList(BuildContext context, DocumentSnapshot data){
    final record = db.todo.fromSnapshot(data);
    return Column(
        children: <Widget>[
            ListTile(
            title:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Checkbox(value: record.isdone, onChanged: (bool value) {
                    setState(() {
                      record.reference.updateData({'isdone': !record.isdone });
                    });
                  }),
                  Text(record.work),
                  SizedBox(width:110),
                  record.isdue ? Text(record.duemonth+'월 '+record.dueday+'일 ' + record.duehour +'시 ' + record.duemin + '분',textAlign: TextAlign.end,) : Text(' '),
                ],
             ),
            ),
              Divider(height: 10.0,),
        ],
      );
    }

  Widget _doneTodoList(BuildContext context, DocumentSnapshot data){
    final record = db.todo.fromSnapshot(data);
    return Column(
      children: <Widget>[
        ListTile(
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Color(0xFFFFCA28),
                  size: 30,
                ),
                onPressed: () {
                  _showDialog(data);
                },
              ),
              Text(record.work),
              SizedBox(width:110),
              record.isdue ? Text(record.duemonth+'월 '+record.dueday+'일 ' + record.duehour +'시 ' + record.duemin + '분',textAlign: TextAlign.end,) : Text(' '),
            ],
          ),
        ),
        Divider(height: 10.0,),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    List<String> _list = [];
  }
  @override
  Widget build(BuildContext context) {
    _getCurrentUser();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('할 일 목 록'),
        backgroundColor: Color(0xFFFFCA28),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20,),
          Text('해야 할 일',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Expanded(
            child: StreamBuilder(
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
                }),
          ),
          Divider(height: 15.0, color: Color(0xFFFFCA28), ),
          Text('완료 한 일', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Expanded(
            child: StreamBuilder(
                stream: Firestore.instance.collection('pet').document(
                    tabrecord.petname + tabrecord.uid)
                    .collection('todo')
                    .where('isdone', isEqualTo: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, i) =>
                            _doneTodoList(context,snapshot.data.documents[i])
                    );
                  } else {
                    return Container(
                        child: Center(
                          child: Text("Loading.."),
                        ));
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.of(context).pushNamed('/addtodo');
        },
        tooltip: '할 일 추가',
        child: Icon(Icons.add,),
        backgroundColor: Color(0xFFFFCA28),
      ),
    );
  }
}
