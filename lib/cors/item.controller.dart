import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epp_film/ui/utiles/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuid/nuid.dart';
import 'package:path/path.dart';

class ItemController extends GetxController{
  final uid = Nuid.instance;
  RxBool adding = false.obs;
  final storage = FirebaseFirestore.instance;
  File? logo;
  List<File> images = [];
  var description = TextEditingController();
  var reservation = TextEditingController();
  var project  = TextEditingController();
  var reference = TextEditingController();
  var tags = TextEditingController();
  var style = TextEditingController();
  var name = TextEditingController();
  var url = "".obs;
  RxString child = "467816".obs;
  FirebaseStorage upload = FirebaseStorage.instance;
  void setChild({required id}){
    child(id);
    update();
  }
  Future uploadPic(File file) async {
      try{
        final name1 = basename(file.path);
        final reference = upload.ref().child("images").child(name1);
        final uploadTask = reference.putFile(file);
        String sUrl = await uploadTask.then((result) => result.ref.getDownloadURL());
        url = sUrl.obs;
        update();
    }catch(e){
        debugPrint(e.toString());
        handleSnackBar("Error","Some thing Going Wrong",Colors.red);
    }
  }
  Future uploadPicToPage(File file,String id) async {
    try{
      final name1 = basename(file.path);
      final reference = upload.ref().child("alls/$id").child(name1);
      final uploadTask = reference.putFile(file);
      await uploadTask.then((result) => result.ref.getDownloadURL());
      update();
    }catch(e){
      debugPrint(e.toString());
      handleSnackBar("Error","Some thing Going Wrong",Colors.red);
    }
  }
  void pickImage()async {
    var image = await ImagePicker().pickMultiImage(imageQuality: 35);
    if(image.isNotEmpty){
      logo = File(image[0].path);
      for(var i in image){
        images.add(File(i.path));
        update();
      }
    }
    update();
  }
  void handleAddItem() async {
    adding(true);
    update();
    await uploadPic(logo!);
    if(url.value.isEmpty){
      handleSnackBar("Error","Some thing Going Wrong",Colors.red);
      adding(false);
      update();
      return ;
    }
    Map<String,dynamic> data = {
      "description": description.text,
      "reservation": reservation.text,
      "date": FieldValue.serverTimestamp(),
      "project": project.text,
      "reference": reference.text,
      "image": url.value,
      "name": name.text,
      "style": style.text,
      "tags": tags.text,
    };
    CollectionReference items =  storage.collection("Items").doc(child.value).collection("items");
    try{
      var add = await items.add(data);
      for(var file in images){
        uploadPicToPage(file, add.id);
      }
      adding(false);
      clear();
      Get.back();
      handleSnackBar("Added","Item Added Successfully",Colors.green);
      update();
    }catch(e){
      debugPrint(e.toString());
      handleSnackBar("Failed to Insert","Something is Wrong",Colors.red);
    }
  }

  void updateItem({required id,required data,required String field})async{
    CollectionReference items =  storage.collection("Items").doc(child.value).collection("items");
    final mf = field.toLowerCase();
    Map<String, dynamic> dat = {
      mf: data,
    };
    try{
      await items.doc(id).update(dat);
      handleSnackBar("Updated","Item Updated Successfully",Colors.green);
    }catch(_){
      handleSnackBar("Failed to Insert","Something is Wrong",Colors.red);
    }
  }
  void deleteItem({required id}){
    CollectionReference items =  storage.collection("Items").doc(child.value).collection("items");
    Get.dialog(
      Dialog(
        backgroundColor: lightBackgroundColor,
        child: Container(
          margin: const EdgeInsets.only(left: 10,top: 10),
          height: 105,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Are Sure to Delete Item",style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),),
              Container(
                margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: const Text("Cancel")
                  ),
                  const SizedBox(width: 10,),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red,)
                      ),
                      onPressed: () async {
                        try{
                          await items.doc(id).delete();
                          Get.back();
                          handleSnackBar("Delete","Item Deleted Successfully",Colors.green);
                        }catch(_){
                          handleSnackBar("Failed to Delete","Something is Wrong Check Connection",Colors.red);
                        }
                      },
                      child: const Text("Delete")),
                  const SizedBox(width: 10,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void deleteImage({required int index}){
    images.removeAt(index);
    update();
  }
  void clear(){
    List<File> images = [];
     description.clear();
    reservation.clear();
    project.clear();
    reference.clear();
    tags.clear();
    style.clear();
    name.clear();
    update();
  }
  void handleSnackBar(title,context,color){
    Get.snackbar(title,context,
      borderRadius: 8.0,
      margin: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
      backgroundColor: color,
      duration: const Duration(seconds: 6),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}