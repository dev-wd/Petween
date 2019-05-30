import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

String userUID;
String userEmail;
FirebaseUser user;
File image;

List<String> kindCat = ['노르웨이숲고양이','데본렉스','라가머핀','리팜','랙돌','러시안블루','맹크스고양이','메인쿤','발리네즈','버만','버마즈','봄베이','시베리아고양이','샴고양이','셀커크렉스','소말리','스코티시폴드','스핑크스','싱갸퓨라','아메리칸밤테일'];

class db {
  String userName;
  String email;
  String birthyear;
  String birthmonth;
  String birthday;
  String meetyear;
  String meetmonth;
  String meetday;
  String gender;
  String kind;
  String uid;
  String nickname;  //고양이 닉네임
  String petname;//고양이이름
  String image; //고양이 사진
  String title; //QNA 제목
  String info; //QNA 내용
  String informationID;
  String isCommand;
  String url;

  final DocumentReference reference;

  db.fromMap(Map<String, dynamic> map, String docID, {this.reference})
      : assert(map['petname'] != null),
        assert(map['nickname'] != null),
        assert(map['uid'] != null),
        assert(map['kind'] != null),
        assert(map['gender'] != null),
        assert(map['meetday'] != null),
        assert(map['meetmonth'] != null),
        assert(map['meetyear'] != null),
        assert(map['birthyear'] != null),
        assert(map['birthmonth'] != null),
        assert(map['birthday'] != null),
        birthday = map['birthday'],
        birthmonth = map['birthmonth'],
        birthyear = map['birthyear'],
        meetyear = map['meetyear'],
        meetmonth = map['meetmonth'],
        meetday = map['meetday'],
        gender = map['gender'],
        kind = map['kind'],
        nickname = map['nickname'],
        petname = map['petname'],
        uid = map['uid'],
        image = map['image'],
        title = map['title'],
        info = map['info'],
        informationID = map['informationID'];

  db.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data, snapshot.documentID, reference: snapshot.reference);

  @override
  String toString() => "db<$userName:$email:$gender:$kind:$nickname:$petname:$uid:$informationID:$isCommand:$url>";

}


class information {
  String userName;
  String email;
  final DocumentReference reference;

  information.fromMap(Map<String, dynamic> map, String docID, {this.reference})
      : assert(map['userName'] != null),
        assert(map['email'] != null),
        userName = map['userName'],
        email = map['email'];
  information.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data, snapshot.documentID, reference: snapshot.reference);

  @override
  String toString() => "information<$userName:$email:>";
}


class nyanggaebu {
  String productkind;
  String productname;
  String productprice;
  bool isbought;
  final DocumentReference reference;

  nyanggaebu.fromMap(Map<String, dynamic> map, String docID, {this.reference})
      : assert(map['productkind'] != null),
        assert(map['productname'] != null),
        assert(map['productprice'] != null),
        assert(map['isbought'] != null),
        productkind = map['productkind'],
        productname = map['productname'],
        productprice = map['productprice'],
        isbought = map['isbought'];
  nyanggaebu.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data, snapshot.documentID, reference: snapshot.reference);

  @override
  String toString() => "nyanggaebu<$productkind:$productname:$productprice:$isbought>";

}

class todo {
  String work;
  bool isdone;
  final DocumentReference reference;

  todo.fromMap(Map<String, dynamic> map, String docID, {this.reference})
      : assert(map['work'] != null),
        assert(map['isdone'] != null),
        work = map['work'],
        isdone = map['isdone'];
  todo.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data, snapshot.documentID, reference: snapshot.reference);

  @override
  String toString() => "todo<$work:$isdone>";

}


class qna{
  String info;
  String title;
  bool isexpanded;
  final DocumentReference reference;

  qna.fromMap(Map<String, dynamic> map, String docID, {this.reference})
  : assert(map['info'] != null),
  assert(map['title'] != null),
  assert(map['isexpanded']!=null),
  info = map['info'],
  title = map['title'],
  isexpanded = map['isexpanded'];
  qna.fromSnapshot(DocumentSnapshot snapshot)
  :this.fromMap(snapshot.data, snapshot.documentID, reference: snapshot.reference);

  @override
  String toString() => "qna<$info:$title:$isexpanded>";
}