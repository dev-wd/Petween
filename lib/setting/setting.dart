import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:petween/model/db.dart' as db;

FirebaseUser mCurrenUser;
List<bool> expandedStatus =[false,false];
List<DropdownMenuItem> drop = [];

class SettingPage extends StatefulWidget {
  db.db record;
  SettingPage({Key key, this.record}) : super(key: key);
  @override
  _SettingPageState createState() => new _SettingPageState(record: record);
}

class _SettingPageState extends State<SettingPage>{
  db.db record;
  _SettingPageState({this.record});
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignin = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('환경설정',style: TextStyle(color: Color(0xFF5D4037))),
            backgroundColor: Color(0xFFFFCA28),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                child: Text('로그아웃'),
                onPressed:(){
                  db.user.isAnonymous ? _auth.signOut():_googleSignin.signOut();

                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/login');
                  },
              ),
              SizedBox(height: 20.0),
              FlatButton(
                child: Text('개인정보 수정'),
                onPressed:(){ Navigator.pop(context);
                Navigator.of(context).pushNamed('/edit');},
              ),
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded){
                  setState(() {
                    expandedStatus[index]=!isExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded){
                      return ListTile(
                        title: Text("개발자 정보", textAlign: TextAlign.center,),
                      );
                    },
                    isExpanded: expandedStatus[0],
                    body: Column(
                      children: <Widget>[
                        Text('김수용'),
                        SizedBox(height: 16.0,),
                        Text('김보희'),
                        SizedBox(height: 16.0,),
                        Text('유진주'),
                        SizedBox(height: 16.0,),
                      ],
                    )
                  ),
                  ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded){
                        return ListTile(
                          title: Text("버전 정보", textAlign: TextAlign.center,),
                        );
                      },
                      isExpanded: expandedStatus[1],
                      body: Column(
                        children: <Widget>[
                          Text('PETWEEN 1.0v'),
                          SizedBox(height: 16.0,),
                        ],
                      )
                  )
                ],
              ),
            ],
          )
        )
    );
  }
}