import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String userUID;
String userEmail;
FirebaseUser user;


class db {
  String pet;
  String userName;
  String email;
  final DocumentReference reference;

  db.fromMap(Map<String, dynamic> map, String docID, {this.reference})
      : assert(map['pet'] != null),
        assert(map['name'] != null),
        assert(map['email'] != null),
        pet = map['pet'],
        userName = map['name'],
        email = map['email'];


  db.fromSnapshot(DocumentSnapshot snapshot)
    :this.fromMap(snapshot.data, snapshot.documentID, reference: snapshot.reference);

  @override
  String toString() => "db<$pet:$userName:$email>";

}