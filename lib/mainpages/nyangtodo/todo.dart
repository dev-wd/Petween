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


class _TodoPageState extends State<TodoPage> {
  db.db record;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _getCurrentUser() async {
    mCurrentUser = await FirebaseAuth.instance.currentUser();
    print(mCurrentUser.uid.toString());
  }


  Widget _TodoList(BuildContext context, DocumentSnapshot data){
    final record = db.todo.fromSnapshot(data);
    return Column(
        children: <Widget>[
    ListTile(
    title:Row(
        children: <Widget>[
        Checkbox(value: record.isdone, onChanged: (bool value) {
          setState(() {
            record.reference.updateData({'isdone': !record.isdone });
          });
        }),
      Text(record.work)
      ],
      ),


      ),
      Divider(
      height: 10.0,
      ),],
      );
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
