import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petween/model/db.dart' as db;

class AddNyangStaPage extends StatefulWidget {
  @override
  _AddNyangStaPageState createState() => new _AddNyangStaPageState();
}

class _AddNyangStaPageState extends State<AddNyangStaPage>{

  String uid;
  String c_time;
  String name;
  String url;
  bool _value1 = false;

  void _onChanged1(bool value) => setState(() => _value1 = value);

  final _contentController = TextEditingController();

  FirebaseStorage storage = FirebaseStorage.instance ;

  Future getImage() async{
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery);

    setState(() {
      db.image = image;
    });

    StorageReference ref = storage.ref().child('${db.image}.jpg');
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
                      style: TextStyle(color: Colors.white, fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
//                onTap: (){
//                    Map<String, dynamic> info = {
//                      'uid' = uid,
//                      'url' = url,
//                      ''
//                    };
//                },
              ),
            ),
          ],
        ),
        body:
        ListView(
          children: <Widget>[
           Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Padding(
                 padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
                 child: FlatButton(
                     onPressed: getImage,

                     child: db.image == null ?
                     Image.asset('assets/nyangsta.png',
                       width: 150.0, height: 150.0, fit: BoxFit.scaleDown,)
                         :
                     Image.file(db.image),
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
                          color: Colors.redAccent,
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

                  Padding(
                    padding: EdgeInsets.fromLTRB(180, 0, 0, 0),
                    child: Switch(
                        value: _value1,
                        onChanged: _onChanged1,
                        activeColor: Colors.redAccent,
                    ),
                  )
                ],
              )
            )
          ],
        )
    );
  }
}