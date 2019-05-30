import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petween/model/db.dart';
import 'package:petween/mainpages/nyanggaebu/nyanggaebu.dart';


<<<<<<< HEAD



int totalPrice;

Color _kindcolor(String kindc){

  if(kindc == "간식")
    return Colors.blueGrey;
  else if(kindc == "장난감")
    return Colors.deepPurpleAccent;
  else if(kindc == "사료")
    return Colors.redAccent;
  else if(kindc == "캣타워")
    return Colors.amber;
  else if(kindc == "스크래쳐")
    return Colors.teal;
  else if(kindc == "이동장")
    return Colors.indigo;
  else if(kindc == "모래")
    return Colors.orange;
}





=======
>>>>>>> origin/bohee
Widget _buildTile(BuildContext context, DocumentSnapshot data){
  final record = nyanggaebu.fromSnapshot(data);
  return Column(
    children: <Widget>[
      ListTile(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right:16.0),
                  child: Text(record.productkind,style: TextStyle(color: _kindcolor(record.productkind),fontSize: 10,fontWeight: FontWeight.bold)),
                ),
                Text(record.productname),
              ],
            ),

            Text(record.productprice+" 원",style: TextStyle(color: Colors.grey,fontSize: 15),),


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
                        itemBuilder: (context, i) {
                          final recordf = nyanggaebu.fromSnapshot(snapshot.data.documents[i]);
                          return Dismissible(
                            // Each Dismissible must contain a Key. Keys allow Flutter to
                            // uniquely identify Widgets.
                              key: Key(recordf.productname+recordf.productprice),
                              // We also need to provide a function that tells our app
                              // what to do after an item has been swiped away.
                              onDismissed: (direction) {
                                setState(() {
                                  Firestore.instance.collection('information').document(curUID)
                                      .collection('nyanggaebu').document(recordf.productname+recordf.productprice).delete();
                                });


                              },
                              // Show a red background as the item is swiped away
                              background: Container(color: Colors.red),
                              child:  _buildTile(context, snapshot.data.documents[i])
                          );
                        }
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
