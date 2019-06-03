import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petween/mainpages/nyangtodo/todo.dart';
import 'package:petween/model/db.dart';
import 'package:petween/tab.dart';

var _todoController = TextEditingController();

String _duemonth = null;
String _dueday = null;
String _duehour = null;
String _duemin = null;
bool isdue = false;

List<DropdownMenuItem<String>> dropday = [];
List<DropdownMenuItem<String>> dropmonth = [];
List<DropdownMenuItem<String>> drophour = [];
List<DropdownMenuItem<String>> dropmin = [];
List<dynamic> _list = [];
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
  bool _date2 = false;

  void dateChanged2(bool value){
    setState((){
      _date2 = value;
    });
  }

  void loadData(){
    dropday = [];
    dropmonth = [];
    drophour = [];
    dropmin = [];

    for(int j=1; j<=12; j++){
      dropmonth.add(new DropdownMenuItem<String>(
        child: Text(j.toString()),
        value: j.toString(),
      ));
    }

    for(int x=1; x<=31; x++){
      dropday.add(new DropdownMenuItem<String>(
        child: Text(x.toString()),
        value: x.toString(),
      ));
    }

    for(int w=1; w<=24; w++){
      drophour.add(new DropdownMenuItem<String>(
        child: Text(w.toString()),
        value: w.toString(),
      ));
    }

    for(int e=0; e<=59; e++){
      dropmin.add(new DropdownMenuItem<String>(
        child: Text(e.toString()),
        value: e.toString(),
      ));
    }
  }

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
    _list = tabrecord.alarm;
    _getUID().then((val) => setState(() {
      _currentUser = val;
      _curUID = _currentUser.uid;
      _curEmail = _currentUser.email;
    }));
  }

  @override
  Widget build(BuildContext context){
    loadData();
    return Scaffold(
        appBar: AppBar(
          title: Text("할 일 추 가"),
          backgroundColor: Color(0xFFFFCA28),
          actions: <Widget>[
            FlatButton(
              child: Text('확인',style: TextStyle(color: Color(0xFFFF5A5A))),
              onPressed:(){
                Map<String, dynamic> todoinfo = {
                  'work': _todoController.text,
                  'isdone' : false,
                  'isdue' : isdue,
                  'duemonth' : _duemonth,
                  'dueday' : _dueday,
                  'duehour' : _duehour,
                  'duemin' : _duemin,
                };
                Firestore.instance.collection('pet').document(tabrecord.petname+_curUID).collection('todo').document().setData(todoinfo);
                if(isdue){
                  Firestore.instance.collection('pet').document(tabrecord.petname+_curUID).collection('Isdue').document().setData(todoinfo);

                }
                _todoController.clear();
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/todo');
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
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(border: Border.all(color: Color(0xFFFFCA28))),
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded){
                    setState(() {
                      isdue=!isdue;
                    });
                  },
                  children: [
                    ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded){
                          return ListTile(
                            title: Text("due date 설정", textAlign: TextAlign.center,),
                          );
                        },
                        isExpanded: isdue,
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    DropdownButton<String>(
                                      value: _duemonth,
                                      items: dropmonth,
                                      hint: Text('목표 달'),
                                      onChanged: (value){
                                        setState(() {
                                          _duemonth = value;
                                        });
                                      },
                                    ),
                                    Text('월'),
                                    SizedBox(width: 16.0,),
                                    DropdownButton<String>(
                                      value: _dueday,
                                      items: dropday,
                                      hint: Text('목표 일'),
                                      onChanged: (value){
                                        setState(() {
                                          _dueday = value;
                                        });
                                      },
                                    ),
                                    Text('일'),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    DropdownButton<String>(
                                      value: _duehour,
                                      items: drophour,
                                      hint: Text('목표 시'),
                                      onChanged: (value){
                                        setState(() {
                                          _duehour = value ;
                                        });
                                      },
                                    ),
                                    Text('시'),
                                    DropdownButton<String>(
                                      value: _duemin,
                                      items: dropmin,
                                      hint: Text('목표 분'),
                                      onChanged: (value){
                                        setState(() {
                                          _duemin = value;
                                        });
                                      },
                                    ),
                                    Text('분'),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),

                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}