import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petween/mainpages/nyangtodo/todo.dart';
import 'package:petween/model/db.dart';

var _todoController = TextEditingController();


class AddTodoPage extends StatefulWidget {
  @override
  _AddTodoPageState createState() => new _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage>{


  var _curUserDocument;
  FirebaseUser _currentUser;
  var _recordinfo;
  String _curUID;
  String _curEmail;

  Future<FirebaseUser> _getUID() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser _currentUsersemi = await _auth.currentUser();
    _curUID = _currentUsersemi.uid.toString();

    _curUserDocument = await Firestore.instance
        .collection('information')
        .document(_curUID)
        .get();
    _recordinfo = information.fromSnapshot(_curUserDocument);
    return _currentUsersemi;
  }

  @override
  void initState() {
    _getUID().then((val) => setState(() {
      _currentUser = val;
      _curUID = _currentUser.uid;
      _curEmail = _currentUser.email;
    }));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text("할 일 추 가"),
          backgroundColor: Color(0xFFFFCA28),
          actions: <Widget>[
            FlatButton(
              child: Text('확인',style: TextStyle(color: Color(0xFFFF5A5A))),
              onPressed:(){
                /*Firestore.instance.collection('pet').document(_todoController.text+_curUID).collection('nyanggaebu').setData(
                    {
]
                    });*/
              }
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFCA28)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFCA28)),
                  ),
                  hintText: '할 일',
                ),
                controller: _todoController,
              ),
            ],
          ),
        )
    );
  }
}