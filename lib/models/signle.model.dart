import 'package:cloud_firestore/cloud_firestore.dart';

class MSingle{
  final String id;
  final String name;
  final Timestamp date;
  MSingle({
    required this.id,
    required this.name,
    required this.date,
  });
  factory MSingle.fromJson({required Map data,required id}){
    return MSingle(
        id: id,
        name: data["itemName"](),
        date: data["time"],
    );
  }
}