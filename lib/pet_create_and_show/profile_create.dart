import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petween/model/db.dart';
import 'package:petween/tab.dart';

class ProfileCreatePage extends StatefulWidget {
  @override
  _ProfileCreatePageState createState() => new _ProfileCreatePageState();
}

Widget _buildCard(BuildContext context, DocumentSnapshot data) {
  final record = db.fromSnapshot(data);

  return Padding(
    padding:
    const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
    child: Container(
      child: FittedBox(
        child: Material(
          color: Colors.white,
          elevation: 2.0,
          borderRadius: BorderRadius.circular(5.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.asset(
                    'assets/examplemanda.jpg',
                    fit: BoxFit.contain,
                    alignment: Alignment.topLeft,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TabPage(record)));
                },
                child: Container(
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  record.petname + " ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                record.gender == "man"
                                    ? Text('M',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: Colors.lightBlue))
                                    : Text(
                                  'W',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                      fontSize: 10),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 24.0, top: 24),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  record.kind,
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.blueGrey),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  record.birthyear,
                                  style: TextStyle(fontSize: 8, color: Colors.grey),
                                ),
                                Text(
                                  '.',
                                  style: TextStyle(fontSize: 8, color: Colors.grey),
                                ),
                                Text(
                                  record.birthmonth,
                                  style: TextStyle(fontSize: 8, color: Colors.grey),
                                ),
                                Text(
                                  '.',
                                  style: TextStyle(fontSize: 8, color: Colors.grey),
                                ),
                                Text(
                                  record.birthday,
                                  style: TextStyle(fontSize: 8, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

var _curUserDocument;
FirebaseUser _currentUser;
String _curUID;

class _ProfileCreatePageState extends State<ProfileCreatePage> {
  var _recordinfo;

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
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'P E T W E E N',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xFFFFCA28),
          leading: Text('')),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xFFFFCA28),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/addpet');
          },
          heroTag: null,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('pet')
            .where('uid', isEqualTo: _curUID)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Container(
                child: Center(
                  child: Text("Loading.."),
                ));
          else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.all(2.0),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildCard(context, snapshot.data.documents[index]);
              },
            );
          }
        },
      ),
    );
  }
}