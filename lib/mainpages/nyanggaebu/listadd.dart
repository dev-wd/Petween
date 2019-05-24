import 'package:flutter/material.dart';


String _productkindadd = null;
List<DropdownMenuItem<String>> dropproductkindadd = [];


class ListAddPage extends StatefulWidget {
  @override
  _ListAddPageState createState() => new _ListAddPageState();
}

class _ListAddPageState extends State<ListAddPage>{
  String productname;
  String productprice;
  int _IsBought = 0;

  void loadData(){
    dropproductkindadd = [];

    dropproductkindadd.add(DropdownMenuItem<String>(
      child: Text('사료'),
      value: "사료",
    ));
    dropproductkindadd.add(DropdownMenuItem<String>(
      child: Text('장난감'),
      value: "장난감",
    ));
    dropproductkindadd.add(DropdownMenuItem<String>(
      child: Text('캣타워'),
      value: "캣타워",
    ));
    dropproductkindadd.add(DropdownMenuItem<String>(
      child: Text('간식'),
      value: "간식",
    ));
    dropproductkindadd.add(DropdownMenuItem<String>(
      child: Text('스크래쳐'),
      value: "스크래쳐",
    ));
    dropproductkindadd.add(DropdownMenuItem<String>(
      child: Text('이동장'),
      value: "이동장",
    ));
    dropproductkindadd.add(DropdownMenuItem<String>(
      child: Text('모래'),
      value: "모래",
    ));





  }


  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
        appBar: AppBar(
          title: Text('냥계부 추가'),
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/tab');
            },
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {  });
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top:16.0,right: 16),
                  child: Text('확인',style: TextStyle(color:  Color(0xFFFF5A5A))),
                ),
              ),
            )

          ],
          backgroundColor: Color(0xFFFFCA28),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text('구입여부',style: TextStyle(color:  Color(0xFFFF5A5A))),
              Row(
                children: <Widget>[
                  Text('이미 구입함'),
                  Radio(
                    value: 1,
                    groupValue:_IsBought,
                    onChanged: (int value){
                      setState(() {
                        _IsBought = value;
                      });
                    },
                  ),
                  Text('구입 예정임'),
                  Radio(
                    value: 2,
                    groupValue:_IsBought,
                    onChanged: (int value){
                      setState(() {
                        _IsBought = value;
                      });
                    },
                  ),
              ],),
              Padding(
                padding: const EdgeInsets.only(bottom:1.0),
                child: Text('구매 물품 종류',style: TextStyle(color:  Color(0xFFFF5A5A))),
              ),
              Padding(
                padding: const EdgeInsets.only(left:1.0),
                child: DropdownButton(
                  value: _productkindadd,
                  items: dropproductkindadd ,
                  hint: Text('종류'),
                  onChanged: (value){
                    setState(() {
                      _productkindadd = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:16.0),
                child: Text('물품명',style: TextStyle(color:  Color(0xFFFF5A5A))),
              ),
              TextField(
                cursorColor: Color(0xFFFF5A5A),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Color(0xFFFF5A5A)),
                  ),
                ),

                onChanged: (text) {
                  productname = text;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top:16.0),
                child: Text('물품 가격',style: TextStyle(color:  Color(0xFFFF5A5A))),
              ),
              TextField(
                cursorColor: Color(0xFFFF5A5A),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Color(0xFFFF5A5A)),
                  ),
                ),

                onChanged: (text) {
                  productprice = text;
                },
              ),

            ],
          ),
        )
    );
  }
}