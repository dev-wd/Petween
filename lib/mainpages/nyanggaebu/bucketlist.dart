import 'package:flutter/material.dart';

class BucketListPage extends StatefulWidget {
  @override
  _BucketListPageState createState() => new _BucketListPageState();
}

class _BucketListPageState extends State<BucketListPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(children: <Widget>[
      Center(
        child: IconButton(
            icon: Icon(Icons.thumb_up),
            onPressed: () {
              Navigator.of(context).pushNamed('/setting');
            }),
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
