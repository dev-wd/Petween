import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petween/model/db.dart';
import 'package:petween/mainpages/nyanggaebu/nyanggaebu.dart';

String _boughtproduct = '전체';
List<DropdownMenuItem<String>> dropboughtyear = [];
List<DropdownMenuItem<String>> dropboughtmonth = [];
List<DropdownMenuItem<String>> dropproductkind = [];

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
class ExpenseListPage extends StatefulWidget {
  @override
  _ExpenseListPageState createState() => new _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {


  void loadData() {
    dropproductkind = [];
    dropproductkind.add(DropdownMenuItem<String>(
      child: Text('전체'),
      value: "전체",
    ));

    dropproductkind.add(DropdownMenuItem<String>(
      child: Text('사료'),
      value: "사료",
    ));
    dropproductkind.add(DropdownMenuItem<String>(
      child: Text('장난감'),
      value: "장난감",
    ));
    dropproductkind.add(DropdownMenuItem<String>(
      child: Text('캣타워'),
      value: "캣타워",
    ));
    dropproductkind.add(DropdownMenuItem<String>(
      child: Text('간식'),
      value: "간식",
    ));
    dropproductkind.add(DropdownMenuItem<String>(
      child: Text('스크래쳐'),
      value: "스크래쳐",
    ));
    dropproductkind.add(DropdownMenuItem<String>(
      child: Text('이동장'),
      value: "이동장",
    ));
    dropproductkind.add(DropdownMenuItem<String>(
      child: Text('모래'),
      value: "모래",
    ));
  }

  @override
  void initState() {


    loadData();
    totalPrice = 0;
  }


  @override
  Widget build(BuildContext context) {



    return Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Text('구입품 종류'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: DropdownButton(
                  value: _boughtproduct,
                  items: dropproductkind,
                  hint: Text('종류'),
                  onChanged: (value3) {
                    setState(() {
                      _boughtproduct = value3;
                    });
                  },
                ),
              ),
            ],
          ),
          Container(
            height: 1.5,
            color: Color(0xFFD8D8D8),
          ),
          Expanded(
            child: StreamBuilder(
                stream: _boughtproduct == '전체' ? Firestore.instance.collection('information').document(curUID)
                    .collection('nyanggaebu').where('isbought',isEqualTo: true).snapshots():
                Firestore.instance.collection('information').document(curUID)
                    .collection('nyanggaebu').where('isbought',isEqualTo: true).where('productkind',isEqualTo: _boughtproduct).snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.data != null){

                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, i) {
                          final recordf = nyanggaebu.fromSnapshot(snapshot.data.documents[i]);
                          return Dismissible(
                            key: Key(recordf.productname+recordf.productprice),
                            // We also need to provide a function that tells our app
                            // what to do after an item has been swiped away.
                            onDismissed: (direction) {
                              // Remove the item from our data source.
                              setState(() {



                                Firestore.instance.collection('information').document(curUID)
                                    .collection('nyanggaebu').document(recordf.productname+recordf.productprice).delete();


                                // remove database nyanggaebu data
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
            color: Color(0xFFFFDF7E),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    '총 지출액',
                    style: TextStyle(
                      color: Color(0xFFFF5A5A),
                    ),
                  ),
                  Text(totalPrice.toString()+' 원'),
                ],
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}

Widget _buildTile(BuildContext context, DocumentSnapshot data){
  final record = nyanggaebu.fromSnapshot(data);
  totalPrice = totalPrice + int.parse(record.productprice)~/2;


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