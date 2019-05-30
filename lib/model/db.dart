import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

String userUID;
String userEmail;
FirebaseUser user;
File image;
String userNickName;

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
  String nickname;
  String petname;

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
        uid = map['uid'];
  db.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data, snapshot.documentID, reference: snapshot.reference);

  @override
  String toString() => "db<$birthday:$birthmonth:$birthyear"
      ":$meetyear:$meetmonth:$meetday:$gender:$kind:$nickname:$petname:$uid>";

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

class nyangsta {
  bool isCommand;
  String nyangImageUrl;
  Timestamp curruentTime;
  bool isLike;
  int likeNum;
  String write;
  List<dynamic> liker;
  String uid;
  List<dynamic> selfCommand;
  int chatNum;
  List<dynamic> chatUser;
  String documentID;

  final DocumentReference reference;

  nyangsta.fromMap(Map<String, dynamic> map, String docID, {this.reference})
      : assert(map['nyangImageUrl'] != null),
        isCommand = map['isCommand'],
        nyangImageUrl = map['nyangImageUrl'],
        curruentTime = map['currentTime'],
        write = map['write'],
        likeNum = map['likeNum'],
        liker = map['liker'],
        isLike = map['isLike'],
        uid = map['uid'],
        chatUser = map['chatUser'],
        chatNum = map['chatNum'],
        selfCommand = map['selfCommand'],
        documentID = docID;


  nyangsta.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data, snapshot.documentID, reference: snapshot.reference);

  @override
  String toString() => "nyangsta<$isCommand:$write:$nyangImageUrl:$curruentTime:$liker:$likeNum:$isLike:$uid:$chatUser:$selfCommand:$chatNum>";
}
