import 'package:epp_film/ui/page/allitempage.dart';
import 'package:epp_film/ui/page/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  final auth  = FirebaseAuth.instance;
  void handleLogin({required String email,required String password}) async {
    if(email.isEmpty && password.length>=6){
      handleSnackBar();
    }
    else{
      try{
        await auth.signInWithEmailAndPassword(email: email, password: password);
        Get.offAll(() => const AllItemsPage());
      }
      catch (_){
        handleSnackBar();
      }
    }
  }
  void handleSnackBar(){
    Get.snackbar("Login Failed", "Wrong Username or Password" ,
      borderRadius: 8.0,
      margin: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 6),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}