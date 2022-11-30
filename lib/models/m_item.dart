import 'package:cloud_firestore/cloud_firestore.dart';

class MItem{
  final String id;
  final String name;
  final String description;
  final String date;
  final String reservation;
  final String project;
  final String reference;
  final String image;
  final String style;
  final String tags;
  MItem({
        required this.id,
        required this.name,
        required this.description,
        required this.date,
        required this.tags,
        required this.style,
        required this.reservation,
        required this.project,
        required this.reference,
        required this.image});
  factory MItem.fromJson({required Map data,required id}){
    return MItem(
        id: id,
        name: data["name"],
        description: data["description"],
        date: data["date"].toDate().toString(),
        reservation: data["reservation"],
        style: data["style"],
        project: data["project"],
        reference: data["reference"],
        image: data["image"],
        tags: data["tags"]
    );
  }
}