import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petween/model/db.dart' as db;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petween/tab.dart';


class AddNyangStaPage extends StatefulWidget {
  @override
  _AddNyangStaPageState createState() => new _AddNyangStaPageState();
}


class _AddNyangStaPageState extends State<AddNyangStaPage>{

  String uid;
  String url;
  DateTime ctime = DateTime.now();
  bool _value1 = false;
  bool _isCommand = false;

  final _contentController = TextEditingController();

  void _onChanged1(bool value){
    setState(() {
      _value1 = value;
      _isCommand = true;
    });
  }

  FirebaseStorage storage = FirebaseStorage.instance ;

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery);

    setState(() {
      db.image = image;
    });

    StorageReference ref = storage.ref().child("nyangsta").child('/${db.image}');
    StorageUploadTask uploadTask = ref.putFile(db.image);
    String URL = await (await uploadTask.onComplete).ref.getDownloadURL();

    setState(() {
      url = URL;
      uid = db.userUID;
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('새 게시물'),
          backgroundColor: Color(0xFFFFCA28),
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                  child: Text('취소',
                      style: TextStyle(color: Colors.white, fontSize: 16.0,
                          fontWeight: FontWeight.bold))),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 15, 0),
              child: GestureDetector(
                child: Container(
                  child: Text('저장',
                      style: TextStyle(color: Color(0xFFFF5A5A), fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
                onTap: (){
                    Map<String, dynamic> nyangstainfo = {
                      'nyangImageUrl': url,
                      'currentTime': ctime,
                      'uid': db.userUID,
                      'likeNum': 0,
                      'write' : _contentController.text,
                      'liker' :[],
                      'isLike' : false,
                      'isCommand': _isCommand,
                      'chatNum': 0,
                      'compareNickName' :tabrecord.nickname,
                    };

                    Map<String, dynamic> nyangstainfosend = {
                      'nyangstaProfileUrl': tabrecord.image,
                      'nyangstaNickName' : tabrecord.nickname,
                    };

                    Firestore.instance.collection('nyangstar').document(tabrecord.nickname).collection('nyangstaBoard').document().setData(nyangstainfo);
                    Firestore.instance.collection('nyangstar').document(tabrecord.nickname).setData(nyangstainfosend);
                    Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
        body:
        ListView(
          children: <Widget>[
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Padding(
                 padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
                 child: FlatButton(
                     child: db.image == null ?
                     Image.asset('assets/nyangsta.png',
                       width: 150.0, height: 150.0, fit: BoxFit.scaleDown,)
                         :
                     Image.file(db.image, width: 150.0, height: 150.0, fit: BoxFit.scaleDown),
                     onPressed: () {
                       getImage();
                     },
                 ),
                ),

             ],
           ),


            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField (
                    controller:_contentController,
                    decoration: InputDecoration(
                      filled: false,
                      hintText: '문구 입력..',
                      fillColor: Color(0x00000000),
                      contentPadding: EdgeInsets.symmetric(vertical:70.0),
                      labelStyle: TextStyle(
                        color: Color(0x00000000),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:  BorderSide(color: Colors.grey),
                      )
                    ),
                  ),
                ]
              ),
            ),

            Padding(
              padding:EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '댓글',
                        style: TextStyle(
                          color: Color(0xFFFF5A5A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 5.0,),

                      Text(
                        '댓글 기능 해제',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 120.0),

                  Switch(
                    value: _value1,
                    onChanged: _onChanged1,
                    activeColor: Colors.redAccent,
                  ),
               ],
              ),
            ),
          ],
        )
    );
  }
}