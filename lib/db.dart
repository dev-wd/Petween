import 'package:cloud_firestore/cloud_firestore.dart';

String userUID;
String userEmail;


class db {
  String pet;
  String name;
  final DocumentReference reference;

  db.fromMap(Map<String, dynamic> map, String docID, {this.reference})
      : assert(map['pet'] != null),
        assert(map['name'] != null),
        pet = map['pet'],
        name = map['name'];


  db.fromSnapshot(DocumentSnapshot snapshot)
    :this.fromMap(snapshot.data, snapshot.documentID, reference: snapshot.reference);

  @override
  String toString() => "db<$pet:$name>";

}