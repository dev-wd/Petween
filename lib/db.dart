import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String userUID;
String userEmail;
FirebaseUser user;
List<String> kindCat = ['노르웨이숲고양이','데본렉스','라가머핀','리팜','랙돌','러시안블루','맹크스고양이','메인쿤','발리네즈','버만','버마즈','봄베이','시베리아고양이','샴고양이','셀커크렉스','소말리','스코티시폴드','스핑크스','싱갸퓨라','아메리칸밤테일'];

class db {
  String pet;
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
  String nickname;
  String name;
  final DocumentReference reference;

  db.fromMap(Map<String, dynamic> map, String docID, {this.reference})
      : assert(map['pet'] != null),
        assert(map['name'] != null),
        assert(map['email'] != null),
        pet = map['pet'],
        userName = map['username'],
        email = map['email'],
        birthday = map['birthday'],
        birthmonth = map['birthmonth'],
        birthyear = map['birthyear'],
        meetyear = map['meetyear'],
        meetmonth = map['meetmonth'],
        meetday = map['meetday'],
        gender = map['gender'],
        kind = map['kind'],
        nickname = map['nickname'],
        name = map['name'];
  db.fromSnapshot(DocumentSnapshot snapshot)
    :this.fromMap(snapshot.data, snapshot.documentID, reference: snapshot.reference);

  @override
  String toString() => "db<$pet:$userName:$email:$gender:$kind:$nickname:$name>";

}