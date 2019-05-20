import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petween/model/db.dart';

class ProfileCreatePage extends StatefulWidget {
  @override
  _ProfileCreatePageState createState() => new _ProfileCreatePageState();
}

Widget _buildBody(
    BuildContext context) {

  return StreamBuilder<QuerySnapshot>(
    stream:  Firestore.instance
        .collection('pet').snapshots(),
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
  );
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
                  record.userName,
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
                      record.pet.toString(),
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



class _ProfileCreatePageState extends State<ProfileCreatePage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title:  Text('P E T W E E N', style: TextStyle(color: Colors.black),),
            backgroundColor: Color(0xFFFFCA28),
            leading: Text('')
        ),
        body: Center(
          child:  Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('name 님! 안녕하세요'),
                  ),
                ],
              ),
              _buildBody(context),
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
