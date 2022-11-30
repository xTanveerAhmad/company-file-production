import 'package:epp_film/cors/auth.controller.dart';
import 'package:epp_film/ui/utiles/constants.dart';
import 'package:epp_film/ui/widgets/mybutoon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authCon = Get.put(AuthController());
  var email = TextEditingController();
  var password = TextEditingController();
  bool secure = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    TextStyle style = const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w800,
    );
    return Scaffold(
      backgroundColor: darkBlueColor,
      body: Container(
        padding: const EdgeInsets.only(left: 10,right: 10),
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(0, 0, 159, 1),
              Color.fromRGBO(0, 0, 225, 1),
            ],
          )
        ),
        child: Center(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Image.asset(bgImage,height: width*0.5,width: width*0.5),
              const SizedBox(height: 15,),
              Image.asset(lockImage,height: 60,width: 60),
              Text("Username",style: style),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: TextField(
                  cursorColor: Colors.black38,
                  controller: email,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "Enter Username"
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Text("Password",style: style),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  cursorColor: Colors.black38,
                  controller: password,
                  obscureText: secure,
                  decoration:  InputDecoration(
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "Enter Password ",
                    suffixIcon: GestureDetector(
                      child: secure?const Icon(Icons.lock,color: Colors.black38,):const Icon(Icons.lock_open,color: Colors.black38),
                      onTap: () => {setState(() {secure = !secure;})},
                    )
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              MyTextButton(text: "LogIn", onPressed: () => authCon.handleLogin(email: email.text.trim(), password: password.text.trim())),
              const SizedBox(height: 10,),
              MyTextButton(text: "Cancel", onPressed: (){}),
            ],
          ),
        ),
      ),
    );
  }
}
