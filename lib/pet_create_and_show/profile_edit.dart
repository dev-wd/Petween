import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petween/model/db.dart' as db;
import 'package:petween/tab.dart';

var _nameController = TextEditingController();
var _nickController = TextEditingController();
int _gender = null;
String _birthyear = tabrecord.birthyear;
String _birthmonth = tabrecord.birthmonth;
String _birthday = tabrecord.birthday;
String _meetyear = tabrecord.meetyear;
String _meetmonth = tabrecord.meetmonth;
String _meetday = tabrecord.meetday;
String _kindCat = tabrecord.kindcat;
List<DropdownMenuItem<String>> dropyear = [];
List<DropdownMenuItem<String>> dropmonth = [];
List<DropdownMenuItem<String>> dropday = [];
List<DropdownMenuItem<String>> dropkind = [];
List<String> gender= ['남','여','중성'];

class ProfileEditPage extends StatefulWidget {
  db.db record;
  ProfileEditPage({Key key, this.record}) : super(key: key);
  @override
  _ProfileEditPageState createState() => new _ProfileEditPageState(record: record);
}

class _ProfileEditPageState extends State<ProfileEditPage>{
  db.db record;
  _ProfileEditPageState({this.record});

  @override
  void initState(){
    //_nameController = TextEditingController(text: record.name);
    //_nickController = TextEditingController(text: record.nickname);

  }
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
        title: Text('프로필 수정', style: TextStyle(color: Color(0xFF5D4037)),),
        backgroundColor: Color(0xFFFFCA28),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('확인'),
            onPressed:(){
              record.reference.updateData(
                  {
                    'username': record.userName,
                    'petname' : _nameController,
                    'kind' : _kindCat,
                    'birthyear' : _birthyear,
                    'birthmonth' : _birthmonth,
                    'birthday' : _birthday,
                    'gender' : gender[_gender],
                    'meetyear' : _meetyear,
                    'meetmonth' : _meetmonth,
                    'meetday' : _meetday,
                    'nickname' : _nickController,
                    'email' : db.userEmail,
                  });
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/setting');
            },
          )
        ],
      ),
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context){
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.
      collection('pet').document(record.petname).snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData) return LinearProgressIndicator();

        return _buildDetail(context, snapshot.data);
      },

    );
  }

  Widget _buildDetail(BuildContext context, DocumentSnapshot data){
    return  ListView(
      padding:
      EdgeInsets.symmetric(horizontal: 24.0),
      children: <Widget>[
        SizedBox(height:10.0),
        Column(
          children: <Widget>[
            //Image.network()
            SizedBox(height: 16.0,)
          ],
        ),
        FlatButton(
          //onPressed: ,
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
                      _birthyear=value;
                    },
                  ),
                ),
                SizedBox(width: 16.0,),
                DropdownButton<String>(
                  value: _birthmonth,
                  items: dropmonth,
                  hint: Text('출생월'),
                  onChanged: (value){
                    _birthmonth=value;
                  },
                ),
                SizedBox(width: 16.0,),
                DropdownButton<String>(
                  value: _birthday,
                  items: dropday,
                  hint: Text('출생일'),
                  onChanged: (value){
                    _birthday=value;
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
                _kindCat = value;
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
                  onChanged: (int value){setState(){
                    _gender = value;
                  }},
                ),
                Text('남'),
                Radio(
                  value: 1,
                  groupValue:_gender,
                  onChanged: (int value){setState(){
                    _gender = value;
                  }},
                ),
                Text('여'),
                Radio(
                  value: 2,
                  groupValue:_gender,
                  onChanged: (int value){setState(){
                    _gender = value;
                  }},
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
                      _meetyear=value;
                    },
                  ),
                ),
                SizedBox(width: 16.0,),
                DropdownButton(
                  value: _meetmonth,
                  items: dropmonth,
                  hint: Text('출생월'),
                  onChanged: (value){
                    _meetmonth=value;
                  },
                ),
                SizedBox(width: 16.0,),
                DropdownButton(
                  value: _meetday,
                  items: dropday,
                  hint: Text('출생일'),
                  onChanged: (value){
                    _meetday=value;
                  },
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

