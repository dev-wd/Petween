import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petween/model/db.dart';
import 'package:petween/mainpages/nyanggaebu/nyanggaebu.dart';









Widget _buildTile(BuildContext context, DocumentSnapshot data){
  final record = nyanggaebu.fromSnapshot(data);
  return Column(
    children: <Widget>[
      ListTile(
        title:Row(
          children: <Widget>[
            Text(record.productkind),
            Text(record.productname),
            Text(record.productprice),

          ],
        ),


      ),
      Divider(
        height: 10.0,
      ),],
  );

}


class BucketListPage extends StatefulWidget {
  @override
  _BucketListPageState createState() => new _BucketListPageState();
}

class _BucketListPageState extends State<BucketListPage> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: Firestore.instance.collection('information').document(curUID)
                    .collection('nyanggaebu').where('isbought',isEqualTo: false).snapshots(),
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

      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            color:  Color(0xFFFFDF7E),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('총 지출액',style: TextStyle(color:  Color(0xFFFF5A5A),),),
                  Text('10000 원'),
                ],
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
