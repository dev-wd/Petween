import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petween/model/db.dart' as db;
import 'package:petween/tab.dart';
import 'package:petween/mainpages/nyangsta/editnyangsta.dart';
import 'package:petween/mainpages/nyangsta/chatnyangsta.dart';
import 'package:petween/mainpages/nyangsta/searchnyangsta.dart';

class NyangStaPage extends StatefulWidget {
  @override
  _NyangStaPageState createState() => new _NyangStaPageState();
}

class _NyangStaPageState extends State<NyangStaPage>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('냥 스 타', textAlign: TextAlign.right,),),
        backgroundColor: Color(0xFFFFCA28),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box,
              color: Color(0xFF5D4037),
            ),
            onPressed: (){
              Navigator.of(context).pushNamed('/addstar');
            },
          ),

          IconButton(
            icon: Icon(Icons.search,
              color: Color(0xFF5D4037),
            ),
            onPressed: (){
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TabPage(tabrecord,1,5)));
            },
          ),

          IconButton(
            icon: Icon(Icons.settings,
              color: Color(0xFF5D4037),
            ),
            onPressed: (){
              Navigator.of(context).pushNamed('/edit');
            },
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }


  Widget _buildBody (BuildContext context){
    return StreamBuilder<QuerySnapshot> (
        stream: Firestore.instance.collection('nyangstar')
            .document(tabrecord.nickname).collection('nyangstaBoard')
            .where('compareNickName', isEqualTo: tabrecord.nickname)
            .orderBy('currentTime', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null){
            return _buildList(context, snapshot.data.documents);
          }
          else{
            return Container(
              child: Center(
                child: Text("Loading.."),
              ),
            );
          }
        }
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
    return GridView.count(
      crossAxisCount: 1,
      padding: EdgeInsets.all(20),
      childAspectRatio: 0.6 / 1.0,
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data){
    final record = db.nyangsta.fromSnapshot(data);

    bool _isUser(){
      if (db.userUID == record.uid){
        return true;
      }
      else return false;
    }

    return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(tabrecord.profileUrl),
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
                    child: Container(
                      child: Text(
                        '${tabrecord.nickname}',
                      ),
                    ),
                  ),

                  SizedBox(width: 80.0,),

                  Container(
                    child:  IconButton(
                        icon: Icon(Icons.more_horiz,
                            color: Colors.grey,
                            size: 30.0),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              EditNyangstaPage(record: record)));
                        }
                    ),
                  ),

                  Container(
                      child: _isUser() ?
                      IconButton(
                        icon: Icon(Icons.delete,
                          color: Colors.grey,
                          size: 20.0,
                        ),
                        onPressed: (){
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return Theme(
                                data: Theme.of(context).copyWith(dialogBackgroundColor: Color(0xFFFFDF7E)),
                                child: AlertDialog(
                                  title: Text("삭제하시겠습니까?",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),),
                                  actions: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        RaisedButton(
                                          child: Text('취소',
                                              style: TextStyle(
                                                color: Colors.white,
                                              )),
                                          color: Color(0xFF5D4037),
                                          onPressed: (){
                                            Navigator.of(context).pop();
                                          },
                                        ),

                                        SizedBox(width: 5.0,),

                                        RaisedButton(
                                          child: Text('확인',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                          color: Color(0xFF5D4037),
                                          onPressed: (){
                                            record.reference.delete();
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      )
                          :
                      null
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.0,),

            AspectRatio(
              aspectRatio: 60.0 / 60.0,
              child: Image(
                image: NetworkImage(record.nyangImageUrl),
                width: 600, height: 600, fit: BoxFit.fitWidth,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: record.isLike ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                    color: Colors.red,
                    iconSize: 30.0,

                    onPressed: (){
                      List l = [];
                      if (!record.liker.contains(db.userUID)){
                        for (int i = 0; i<record.liker.length; i++){
                          l.add(record.liker[i]);
                        }
                        l.add(db.userUID);
                        record.reference.updateData({
                          'liker' : l,
                          'likeNum': record.likeNum +1,
                        });
                      }
                      else{
                        for (int i = 0; i<record.liker.length; i++){
                          l.add(record.liker[i]);
                        }
                        l.remove(db.userUID);
                        record.reference.updateData({
                          'liker': l,
                          'likeNum': record.likeNum -1,
                        });
                      }

                      setState(() {
                        if (record.isLike){
                          record.reference.updateData({'isLike': false});
                        }
                        else{
                          record.reference.updateData({'isLike': true});
                        }
                      });
                    },
                  ),

                  Container(
                    child: record.isCommand ?
                    IconButton(
                      icon: Icon(Icons.chat),
                      color: Colors.redAccent,
                      disabledColor: Colors.redAccent,
                      iconSize: 30.0,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            ChatNyangstaPage(record: record)));
                      },
                    )
                        :
                    null,
                  ),

                  SizedBox(width: 120.0,),

                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      '${record.curruentTime.toDate().year.toString()
                          +"."
                          +record.curruentTime.toDate().month.toString()
                          +"."
                          +record.curruentTime.toDate().day.toString()
                          +"  "
                          +record.curruentTime.toDate().hour.toString()
                          +":"
                          +record.curruentTime.toDate().minute.toString()
                      }',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${tabrecord.nickname}',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5.0,),

                    Text(
                      '${record.write}',
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                )
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '좋아요 ${record.likeNum.toString()} 개',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),

                  SizedBox (width: 8.0,),
                  Text(
                    '댓글 ${record.chatNum.toString()} 개',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }

}