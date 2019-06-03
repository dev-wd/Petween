import 'package:flutter/material.dart';
import 'package:petween/tab.dart';
import 'package:petween/model/db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var controller = TextEditingController();
bool _searched = false;

Widget _buildCard(BuildContext context, DocumentSnapshot data) {
  final record = nyangstainfo.fromSnapshot(data);

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
                width: 30,
                height: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                  record.nyangstaProfileUrl,
                    fit: BoxFit.contain,
                    alignment: Alignment.topLeft,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TabPage(record, 2, 2)));
                },
                child: Container(
                  height: 30,
                  width: 40,
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                                Text(
                                  record.nyangstaNickName + " ",
                                  style: TextStyle(fontSize: 5),
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

class SearchNyangPage extends StatefulWidget {
  @override
  _SearchNyangPageState createState() => new _SearchNyangPageState();
}

class _SearchNyangPageState extends State<SearchNyangPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Color(0xFFFFCA28),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TabPage(tabrecord, 1, 1)));
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: TextField(
                      autofocus: true,
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _searched = true;
                      },
                    ),
                  )),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.69,
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('nyangstar').snapshots(),
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
                        return _buildCard(
                            context, snapshot.data.documents[index]);
                      },
                    );
                  }
                },
              ),
          ),
        ],
      ),
    );
  }
}
