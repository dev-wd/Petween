import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petween/model/db.dart' as db;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petween/tab.dart';


class ChatNyangstaPage extends StatefulWidget {
  db.nyangsta record;
  ChatNyangstaPage({Key key, this.record}) : super(key: key);
  @override
  _ChatNyangstaPageState createState() => new _ChatNyangstaPageState(record: record);
}

class _ChatNyangstaPageState extends State<ChatNyangstaPage>{
  db.nyangsta record;
  _ChatNyangstaPageState({this.record});

  final TextEditingController _chatController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('댓글'),
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
        ),

        body: _builderBody(context),
    );
  }

  Widget _builderBody(BuildContext context){
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.collection('nyangstar').document(record.documentID).snapshots(),
      builder: (context, snapshot){
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildChat(context, snapshot.data);
      },
    );
  }

  Widget _buildChat(context, DocumentSnapshot data){
    final record = db.nyangsta.fromSnapshot(data);

    void _handleSubmit(String text){
      _chatController.clear();

      setState(() {
        List l = [];
        l.add(_chatController.text);

        record.reference.updateData({
        'chatNum' : record.chatNum+1,
          'chatUser': l,
        });
      });
    }
    return Column(
      children: <Widget>[
        Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => record.chatUser[index],
              itemCount: record.chatUser.length,
            )
        ),
        new Divider(
          height: 1.0,
        ),

        Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child:  ListView(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 16.0),
                          child: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(record.nyangImageUrl),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${tabrecord.nickname}',
                              style: Theme.of(context).textTheme.subhead,
                            ),
//                  Container(
//                    margin: EdgeInsets.only(top: 5.0),
//                    child: Text(text),
//                  ),
                          ],
                        )
                      ],
                    )
                ),
              ],
            ),
        ),
      ],
    );

  }
}