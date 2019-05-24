import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petween/model/db.dart';


class ProfileCreatePage extends StatefulWidget {
  @override
  _ProfileCreatePageState createState() => new _ProfileCreatePageState();
}



Widget _buildCard(BuildContext context, DocumentSnapshot data) {
  final record = db.fromSnapshot(data);


  return Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  record.nickname,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                SizedBox(height: 4.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/tab');
                  },
                  child: Container(
                    child: Text(
                      record.petname.toString(),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    ),
  );
}

var _curUserDocument;
FirebaseUser _currentUser;
String _curUID;

class _ProfileCreatePageState extends State<ProfileCreatePage>{

  var _recordinfo;




  Future<FirebaseUser> _getUID() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser _currentUsersemi = await _auth.currentUser();
    _curUID = _currentUsersemi.uid.toString();

    _curUserDocument = await Firestore.instance.collection('information').document(_curUID).get();
    _recordinfo = information.fromSnapshot(_curUserDocument);
    return _currentUsersemi;
  }





  @override
  Widget build(BuildContext context) {
    _getUID().then((val) => setState(() {
      _currentUser = val;
    }));
    return Scaffold(
        appBar: AppBar(
            title:  Text('P E T W E E N', style: TextStyle(color: Colors.black),),
            backgroundColor: Color(0xFFFFCA28),
            leading: Text('')
        ),
        body:  Center(
          child:  Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(_recordinfo.userName+' 님! 안녕하세요'),
                  ),
                ],
              ),
          StreamBuilder<QuerySnapshot>(
            stream:  Firestore.instance
                .collection('pet').where('uid', isEqualTo: _curUID).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();

              return GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: snapshot.data.documents.length,
                padding: EdgeInsets.all(2.0),
                itemBuilder: (BuildContext context, int index) {
                  return _buildCard(context, snapshot.data.documents[index]);
                },
              );
            },
          ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  FlatButton(
                    child: Text('                ADD PET                ',style: TextStyle(color: Colors.white),),
                    color: Color(0xFFFFCA28),
                    onPressed: (){
                      Navigator.of(context).pushNamed('/addpet');
                    },
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}
