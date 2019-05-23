import 'package:flutter/material.dart';


String _boughtyear = null;
String _boughtmonth = null;
String _boughtproduct = null;
List<DropdownMenuItem<String>> dropboughtyear = [];
List<DropdownMenuItem<String>> dropboughtmonth = [];
List<DropdownMenuItem<String>> dropproductkind= [];

class ExpenseListPage extends StatefulWidget {
  @override
  _ExpenseListPageState createState() => new _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage>{

  void loadData(){
    dropboughtyear = [];
    dropboughtmonth = [];
    dropproductkind = [];

    for(int i=2019; i>=1970; i--){
      dropboughtyear.add(new DropdownMenuItem<String>(
        child: Text(i.toString()),
        value: i.toString(),
      ));
    }

    for(int j=1; j<=12; j++){
      dropboughtmonth.add(new DropdownMenuItem<String>(
        child: Text(j.toString()),
        value: j.toString(),
      ));
    }


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
  Widget build(BuildContext context) {
    loadData();

    return Stack(children: <Widget>[

      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('구매 년월'),
                  DropdownButton(
                    value: _boughtyear,
                    items: dropboughtyear ,
                    hint: Text('년도'),
                    onChanged: (value1){
                      setState(() {
                        _boughtyear = value1;
                      });
                    },
                  ),

                  DropdownButton(
                    iconSize: 30,
                    value: _boughtmonth,
                    items: dropboughtmonth ,
                    hint: Text('월'),
                    onChanged: (value2){
                      setState(() {
                        _boughtmonth = value2;
                      });
                    },
                  ),
                ],
              ),

          Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text('구입품 종류'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:40.0),
                    child: DropdownButton(
                      value: _boughtproduct,
                      items: dropproductkind ,
                      hint: Text('종류'),
                      onChanged: (value3){
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


        ],
      ),

      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            color:   Color(0xFFFFDF7E),
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