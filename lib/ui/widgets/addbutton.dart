import 'package:epp_film/ui/page/adddatat.dart';
import 'package:epp_film/ui/utiles/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AddItemButton extends StatelessWidget {
  const AddItemButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Get.to(() => const AddData()),
      backgroundColor: blackColor2,
      child: const Icon(Icons.add,color: Colors.white,),
    );
  }
}
