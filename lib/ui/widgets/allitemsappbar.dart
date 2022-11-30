import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epp_film/ui/utiles/constants.dart';
import 'package:epp_film/ui/widgets/mybutoon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllItemBar extends StatefulWidget {
  const AllItemBar({Key? key}) : super(key: key);
  @override
  State<AllItemBar> createState() => _AllItemBarState();
}

class _AllItemBarState extends State<AllItemBar> {
  var fileName = TextEditingController();
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(0, 0, 159, 1),
              Color.fromRGBO(0, 0, 225, 1),
            ],
          )
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 1000,
        title: const Text(appName),
        actions: [
          GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(top: 10,bottom: 10),
                padding: const EdgeInsets.only(right: 10,left: 10),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(230, 28, 45, 1),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Center(child:  Text("New",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 17),)),
              ),
              onTap: (){
                Get.dialog(
                  Dialog(
                    backgroundColor: lightBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10,top: 10),
                      height: 135,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Enter New Item Name",style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),),
                          Container(
                            margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextField(
                              controller: fileName,
                              autofocus: false,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Item Name",
                                  suffixIcon: GestureDetector(
                                    onTap: () => fileName.clear(),
                                    child: const Icon(Icons.clear),
                                  )
                              ),
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
                                      backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(0, 0, 225, 1),)
                                  ),
                                  onPressed: () async {
                                    var items = db.collection("items");
                                    if(fileName.text.isNotEmpty){
                                      try{
                                        await items.add({
                                          "itemName": fileName.text,
                                          "time": FieldValue.serverTimestamp(),
                                        });
                                        fileName.clear();
                                        Get.back();
                                        handleSnackBar("Added","Item Added Successfully",Colors.green);
                                      }catch(_){
                                        handleSnackBar("Failed to to Create","Something is Wrong Check Connection",Colors.red);
                                      }
                                    }
                                  },
                                  child: const Text("Save")),
                              const SizedBox(width: 10,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          const SizedBox(width: 10,)
        ],
      ),
    );
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
