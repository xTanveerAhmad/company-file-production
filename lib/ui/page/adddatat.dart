import 'package:epp_film/cors/item.controller.dart';
import 'package:epp_film/ui/utiles/constants.dart';
import 'package:epp_film/ui/widgets/addimage.dart';
import 'package:epp_film/ui/widgets/myappbar.dart';
import 'package:epp_film/ui/widgets/mybutoon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final itemCon = Get.put(ItemController());
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Widget myInput(text,controller){
      return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(left: 8,right: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
        ),
        child: TextFormField(
          cursorColor: Colors.black38,
          controller: controller,
          minLines: 1,
          maxLines: 4,
          validator: (value) {
            if (controller.text.isEmpty) {
              return 'Enter $text';
            }
            return null;
          },
          decoration:  InputDecoration(
              fillColor: Colors.white,
              border: InputBorder.none,
              hintText: text,
          ),
        ),
      );
    }
    return  GetBuilder(
      init: itemCon,
      builder: (_) => Scaffold(
        backgroundColor: lightBackgroundColor,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: MyAppBar(),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const AddImage(),
                myInput("Name", itemCon.name),
                myInput("Project", itemCon.project),
                myInput("Reservation", itemCon.reservation),
                myInput("Style", itemCon.style),
                myInput("Description", itemCon.description),
                myInput("Tags", itemCon.tags),
                myInput("Reference", itemCon.reference),
                const SizedBox(height: 10,),
                itemCon.adding.value?Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 3),
                  child: Column(
                    children: const [
                       CircularProgressIndicator(
                         strokeWidth: 3,
                       ),
                    ],
                  ),
                ):MyTextButton(text: "Add Item",onPressed: (){
                  if(formKey.currentState!.validate()){
                    itemCon.handleAddItem();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
