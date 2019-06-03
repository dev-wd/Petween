import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Package:petween/model/db.dart' as db;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:petween/model/db.dart';

var _nameController = TextEditingController();
var _nickController = TextEditingController();
final FirebaseAuth _auth = FirebaseAuth.instance;
int _gender = 0;
String _birthyear = null;
String _birthmonth = null;
String _birthday = null;
String _meetyear = null;
String _meetmonth = null;
String _meetday = null;
String _kindCat = null;
List<DropdownMenuItem<String>> dropyear = [];
List<DropdownMenuItem<String>> dropmonth = [];
List<DropdownMenuItem<String>> dropday = [];
List<DropdownMenuItem<String>> dropkind = [];
List<String> gender= ['남','여','중성'];
List<dynamic> _list = [];

class AddPetPage extends StatefulWidget {
  //ProfileCreatePage({Key key, this.record}) : super(key:key);

  @override
  _AddPetPageState createState() {
    return _AddPetPageState();
  }
}

class _AddPetPageState extends State<AddPetPage>{
  db.db record;
  File _image;
  String imageUrl = 'https://screenshotlayer.com/images/assets/placeholder.png';
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
      print(_currentUser.email);
      _curUID = _currentUser.uid;
      _curEmail = _currentUser.email;
      print("uid:" + _curUID);
    }));


  }


  Future getImage() async {
    print("실행");
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
    print(_image);
    final String rand =
        "${new Random().nextInt(10000)}${DateTime.now().millisecond}";

    final StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('addpet').child('myimage.jpg');
    final StorageUploadTask task =
    firebaseStorageRef.putFile(_image);

    await (await task.onComplete)
        .ref
        .getDownloadURL()
        .then((dynamic url) {
      setState(() {
        imageUrl= url;
        _image = null;
      });}
    );
  }
  //_ProfileCreatePageState({this.record});

  void loadData(){
    dropyear = [];
    dropmonth = [];
    dropday =[];
    dropkind = [];

    for(int i=2019; i>=1970; i--){
      dropyear.add(new DropdownMenuItem<String>(
        child: Text(i.toString()),
        value: i.toString(),
      ));
    }

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

    dropkind = db.kindCat.map((val) => DropdownMenuItem<String>(
      child: new Text(val), value: val,)).toList();

  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      appBar: AppBar(
        title: Text('프 로 필 설 정', style: TextStyle(color: Color(0xFF5D4037)),),
        backgroundColor: Color(0xFFFFCA28),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('확인',style: TextStyle(color: Color(0xFFFF5A5A))),
            onPressed:(){
              String __gender = null;
              if(_gender==0)
                __gender = '남';
              else if(_gender ==1)
                __gender = '여';
              else
                __gender = '중성';
              Firestore.instance.collection('pet').document(_nameController.text+_curUID).setData(
                  { 'petname' : _nameController.text,
                    'kind' : _kindCat,
                    'birthyear' : _birthyear,
                    'birthmonth' : _birthmonth,
                    'birthday' : _birthday,
                    'gender' :__gender,
                    'meetyear' : _meetyear,
                    'meetmonth' : _meetmonth,
                    'meetday' : _meetday,
                    'nickname' : _nickController.text,
                    'email' : _curEmail,
                    'image': imageUrl,
                    'uid' : _curUID,
                  });
              _nameController.clear();
              _nickController.clear();
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/catchoice');

              /*
                Navigator.of(context).push(MaterialPageRoute(
                  builder:(BuildContext context) => ProfileEditPage(record: record)
                ));*/
            },
          )
        ],
      ),
      body: Center(
        child: ListView(
          padding:
          EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height:10.0),
            Column(
              children: <Widget>[
                Image.network(imageUrl, fit: BoxFit.fill),
                SizedBox(height: 16.0),
              ],
            ),
            FlatButton(
              onPressed:(){getImage();},
              child: Icon(Icons.add_a_photo),
            ),
            Column(
              children: <Widget>[
                Text('이름', textAlign: TextAlign.left,),
                TextField(
                  controller: _nameController,
                ),
              ],
            ),
            SizedBox(height: 12.0,),
            Column(
              children: <Widget>[
                Text('닉네임',textAlign: TextAlign.left,),
                TextField(
                  controller: _nickController,
                ),
              ],
            ),
            SizedBox(height: 12.0,),
            Column(
              children: <Widget>[
                Text('출생일'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _birthyear,
                        items: dropyear,
                        hint: Text('출생년도'),
                        onChanged: (value){
                          setState(() {
                            _birthyear = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 16.0,),
                    DropdownButton<String>(
                      value: _birthmonth,
                      items: dropmonth,
                      hint: Text('출생월'),
                      onChanged: (value){
                        setState(() {
                          _birthmonth = value;
                        });
                      },
                    ),
                    SizedBox(width: 16.0,),
                    DropdownButton<String>(
                      value: _birthday,
                      items: dropday,
                      hint: Text('출생일'),
                      onChanged: (value){
                        setState(() {
                          _birthday = value;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 12.0,),
            Column(
              children: <Widget>[
                Text('고양이 종류',textAlign: TextAlign.left,),
                DropdownButton(
                  value: _kindCat,
                  items: dropkind,
                  hint: Text('고양이종류'),
                  onChanged: (value){
                    setState(() {
                      _kindCat = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 12.0,),
            Column(
              children: <Widget>[
                Text('성별'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue:_gender,
                      onChanged: (int value){
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                    Text('남'),
                    Radio(
                      value: 1,
                      groupValue:_gender,
                      onChanged: (int value){
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                    Text('여'),
                    Radio(
                      value: 2,
                      groupValue:_gender,
                      onChanged: (int value){
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                    Text('중성'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.0,),
            Column(
              children: <Widget>[
                Text('함께한 D-day'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _meetyear,
                        items: dropyear,
                        hint: Text('만난연도'),
                        onChanged: (value){
                          setState(() {
                            _meetyear = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 16.0,),
                    DropdownButton(
                      value: _meetmonth,
                      items: dropmonth,
                      hint: Text('만난월'),
                      onChanged: (value){
                        setState(() {
                          _meetmonth = value;
                        });
                      },
                    ),
                    SizedBox(width: 16.0,),
                    DropdownButton(
                      value: _meetday,
                      items: dropday,
                      hint: Text('만난일'),
                      onChanged: (value){
                        setState(() {
                          _meetday = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}