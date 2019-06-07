import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petween/model/db.dart';
import 'package:petween/tab.dart';

class ChatNyangstaPage extends StatefulWidget {
  nyangsta record;
  ChatNyangstaPage({Key key, this.record}) : super(key: key);
  @override
  _ChatNyangstaPageState createState() => new _ChatNyangstaPageState(record: record);
}

class _ChatNyangstaPageState extends State<ChatNyangstaPage>{
  nyangsta record;
  _ChatNyangstaPageState({this.record});

  bool _isComposing = false;
  DateTime ctime;
  String input;

  final TextEditingController _commandController = TextEditingController();

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

      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.collection('nyangstar')
          .document(tabrecord.nickname).collection('nyangstaBoard')
          .document(record.nyangstaDocumentID).snapshots(),
      builder: (context, snapshot){
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildBodyList(context, snapshot.data);
      },
    );
  }

  Widget _buildBodyList(BuildContext context, DocumentSnapshot data){
    final record = nyangsta.fromSnapshot(data);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('nyangstar')
                .document(tabrecord.nickname).collection('nyangstaBoard')
                .document(record.nyangstaDocumentID)
                .collection('nyangcomments').where('dumy', isEqualTo: true)
                .orderBy('commendTime', ).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){

              if (snapshot.data != null){
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, i){
                      final crecord = nyangchat.fromSnapshot(snapshot.data.documents[i]);
                      return Dismissible(

                        key: Key(crecord.toString()),

                        onDismissed: (direction) {
                          setState(() {
                            crecord.reference.delete();
                            record.reference.updateData({'chatNum' : record.chatNum - 1});
                          });
                        },
                        background: Container(color: Colors.red),
                        child:  _buildChat(context, snapshot.data.documents[i]),
                      );
                    }
                );
              }
              else{
                return Container(
                  child: Center(
                    child: Text("Loading.."),
                  ),
                );
              }
            },
          ),
        ),
        Divider(),

        ListTile(
          title: TextField(
            controller: _commandController,
            onChanged: (String text){
              setState(() {
                _isComposing = text.length > 0;
              });
            },
            decoration: InputDecoration(
              hintText: '댓글 달기...',
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(tabrecord.image),
          ),
          trailing: IconButton(
            onPressed: (){

              Firestore.instance.collection('nyangstar')
                  .document(tabrecord.nickname).collection('nyangstaBoard')
                  .document(record.nyangstaDocumentID)
                  .collection('nyangcomments').document(tabrecord.nickname + _commandController.text)
                  .setData({
                'chatUser': tabrecord.nickname,
                'avatarUrl': tabrecord.image,
                'commendTime': ctime = DateTime.now(),
                'commend': _commandController.text,
                'dumy' : true,
              });

              setState(() {
                record.reference.updateData({'chatNum' : record.chatNum + 1});
              });

              _commandController.clear();
            },
            icon: _isComposing ? Icon(Icons.send, color: Color(0xFFFFDF7E))
                : Icon(Icons.send, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildChat(BuildContext context, DocumentSnapshot data){
    final chatrecord = nyangchat.fromSnapshot(data);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(chatrecord.avatarUrl),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${chatrecord.chatUser}',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 5.0,),

              Text(
                '${chatrecord.commend}',
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),

              SizedBox(height: 7.0,),

              Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  '${chatrecord.commendTime.toDate().year.toString()
                      +"/"
                      +chatrecord.commendTime.toDate().month.toString()
                      +"/"
                      +chatrecord.commendTime.toDate().day.toString()
                      +"  "
                      +chatrecord.commendTime.toDate().hour.toString()
                      +":"
                      +chatrecord.commendTime.toDate().minute.toString()
                  }',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 8.0,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}