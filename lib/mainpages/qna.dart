import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petween/model/db.dart' as db;

List<bool> expandedStatus =[false,false];

class QNAPage extends StatefulWidget {
  @override
  _QNAPageState createState() => new _QNAPageState();
}

class _QNAPageState extends State<QNAPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('QNA'),
          backgroundColor: Color(0xFFFFCA28),
        ),
        body: Center(
            child: Column(
              children: <Widget>[
                  SizedBox(height: 20.0),
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded){
                      setState(() {
                        expandedStatus[index]=!isExpanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded){
                            return ListTile(
                              title: Text("건사료를 먹여도 괜찮을까요?", textAlign: TextAlign.left, style: TextStyle(fontWeight:FontWeight.bold ),),
                            );
                          },
                          isExpanded: expandedStatus[0],
                          body: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("건사료가 우리에게 편리한 것은 사실이지만, 육식동물인 고양이에게는 적합하지 않은 음식입니다. 물은 정말 고양이 건강에 매우 중요합니다. 건사료를 주로 먹는 고양이들은 만성적으로 수분이 부족한 상황입니다.이런 수분 부족은 여러가지 건강 문제를 초래할 수 있습니다. 이상적인 야생에서 생활하는 고양이가 먹는 먹이의 65~75%는 수분으로 구성되어 있습니다. 건사료의 수분 함량은 평균적으로 10% 정도이며, 통조림 사료의 수분 함량은 평균적으로 약 78%입니다. 이 사실만 보아도, 고양이가 충분한 수분을 섭취하기 위해서, 건사료보다는 통조림 사료를 먹이는 것이 좋습니다. 고양이는 다른 동물과는 달리, 물을 일부러 찾아 마실려는 본능이 매우 약하기 때문에, 음식을 먹을때 같이 수분을 충분히 섭취하는 것이 더더욱 중요합니다"),
                          )
                      ),
                      ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded){
                            return ListTile(
                              title: Text("고양이, 하품 하는 이유는?", textAlign: TextAlign.left, style: TextStyle(fontWeight:FontWeight.bold ),),
                            );
                          },
                          isExpanded: expandedStatus[1],
                          body: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("고양이가 ‘하품’을 하는 이유에 대해서는 여러 가지 가설이 있다.  생리학 이론: 혈액 속 산소 농도가 낮기 때문에 하품을 한다는 이론. 하품을 통해 심호흡을 하게 되면 호흡기 및 혈액 순환이 원활해진다는 것에 기인 각성론: 깨어있기 위해 하품을 한다는 이론. 고양이가 피곤해하면서 자고 싶어하면서도 어떤 이유에서인지 억지로 잠을 자지 않는 것. 특히, 고양이는 스트레스를 받으면서 어떤 것에 대해 걱정을 할 때 깨어있으려고 애쓰면서 하품을 하기도 함 권태론: 지루하면 하품을 한다는 이론 진화론: 예로부터 내려오는 행동으로, 이빨을 드러내기 위해 하품을 한다는 이론 커뮤니케이션 이론: 하품을 통해 단순히 피곤하다는 것을 주변에 알려주는 행위라는 이론 에너지의 방출: 하품이라는 행동을 통해 근육 운동을 하며 긴장감을 풀 수 있다는 이론"),

                          )
                      ),
                    ],
                  ),
                ],
            )
        )
    );
  }
}