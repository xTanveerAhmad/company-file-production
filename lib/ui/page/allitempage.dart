import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epp_film/cors/item.controller.dart';
import 'package:epp_film/ui/page/homepage.dart';
import 'package:epp_film/ui/page/loginpage.dart';
import 'package:epp_film/ui/utiles/constants.dart';
import 'package:epp_film/ui/widgets/allitemsappbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllItemsPage extends StatefulWidget {
  const AllItemsPage({Key? key}) : super(key: key);
  @override
  State<AllItemsPage> createState() => _AllItemsPageState();
}

class _AllItemsPageState extends State<AllItemsPage> {
  final item = Get.put(ItemController());
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final category = db.collection('items').orderBy('time', descending: true).get();
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AllItemBar(),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: const Text("All Items",
                    textAlign: TextAlign.start,
                    style:  TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                  future: category,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(),);
                    }else if(!snapshot.hasError){
                      return  ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          final mp = snapshot.data!.docs[index].data() as Map;
                          return GestureDetector(
                            onTap: (){
                              item.setChild(id: snapshot.data!.docs[index].id);
                              Get.to(() => const MyHomePage());
                            },
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.only(left: 10,top: 20,bottom: 20),
                              margin: const EdgeInsets.only(top: 10),
                              child: Text(mp["itemName"],style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),),
                            ),
                          );
                        }),
                        itemCount: snapshot.data!.docs.length, // 1000 list items
                      );
                    }else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  }
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: blackColor2,
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
               UserAccountsDrawerHeader(
                currentAccountPicture: Image.asset(bgImage,fit: BoxFit.fitWidth,),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(0, 0, 159, 1),
                        Color.fromRGBO(0, 0, 225, 1),
                      ],
                    )
                ),
                accountName: null,
                accountEmail:const Text("production@masonewingcorp.com",style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                  color: Colors.white,
                ),),
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
      ),
    );
  }
}
