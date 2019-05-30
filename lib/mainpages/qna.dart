import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petween/model/db.dart' as db;

List<bool> expandedStatus =[false,false];

class QNAPage extends StatefulWidget {
  @override
  _QNAPageState createState() => new _QNAPageState();
}



class _QNAPageState extends State<QNAPage> {
  Widget _buildTile(BuildContext context, DocumentSnapshot data){
    final record = db.qna.fromSnapshot(data);
    return Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded){
                setState(() {
                    record.reference.updateData({'isexpanded': !record.isexpanded });
                });
              },
              children: [
                ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded){
                      return ListTile(
                        title: Text(record.title, textAlign: TextAlign.left, style: TextStyle(fontWeight:FontWeight.bold ),),
                      );
                    },
                    isExpanded: record.isexpanded,
                    body: Padding(
                        padding: EdgeInsets.fromLTRB(20, 1, 22, 10),
                        child: Text(record.info, style: TextStyle(fontSize: 15),)
                    )
                ),
              ],
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('꿀 팁 정 보'),
        backgroundColor: Color(0xFFFFCA28),
      ),
      body: Stack(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                  stream: Firestore.instance.collection('qna').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.data != null){
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, i) => _buildTile(context, snapshot.data.documents[i])
                      );

                    }else{
                      return Container(
                          child: Center(
                            child: Text("Loading.."),
                          ));
                    }
                  }),
            ),
          ],
        ),
      ]),
    );
  }
}
