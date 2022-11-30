import 'package:epp_film/provider/searchstate.dart';
import 'package:epp_film/ui/page/loginpage.dart';
import 'package:epp_film/ui/utiles/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final auth = FirebaseAuth.instance;
  final search = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: blackColor2,
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(0, 0, 159, 1),
                        Color.fromRGBO(0, 0, 225, 1),
                      ],
                    )
                ),
                accountName: Text(appName,style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),),
                accountEmail: Text("production@masonewingcorp.com",style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                  color: Colors.white,
                ),),
            ),
            ListTile(
              onTap: () => search.dialogToGetFileName(width),
              leading: const Icon(Icons.outlined_flag_outlined),
              title: const Text("Export as Excel"),
            ),
            ListTile(
              onTap: ()async{
                await auth.signOut();
                Get.offAll(() => const LoginPage());
              },
              leading: const Icon(Icons.lock_open),
              title: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
