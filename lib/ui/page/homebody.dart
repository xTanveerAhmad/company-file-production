
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epp_film/cors/item.controller.dart';
import 'package:epp_film/models/m_item.dart';
import 'package:epp_film/provider/searchstate.dart';
import 'package:epp_film/ui/widgets/datagrid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBodyPage extends StatefulWidget {
  const HomeBodyPage({Key? key}) : super(key: key);
  @override
  State<HomeBodyPage> createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomeBodyPage> {
  final search = Get.put(SearchController());
  final item = Get.put(ItemController());
  final db = FirebaseFirestore.instance;
  late UserDataSource userDataSource;
  List<MItem> userData = [];
  late Stream category;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final category = db.collection('Items').doc(item.child.value).collection("items").snapshots();
    return GetBuilder(
      init: search,
      builder: (_) => Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8,right: 10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 45,
            child: Row(
              children: [
                Container(
                  child: PopupMenuButton(
                      onSelected: search.onSelect,
                      itemBuilder: (BuildContext context) => search.menus.map((e) => PopupMenuItem(
                          value: e,
                          child: Text(e))
                      ).toList(),
                      child: Row(
                        children: [
                          Text(search.selected.value),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      )
                  ),
                ),
                Expanded(child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 40,
                  child: TextField(
                    controller: search.query,
                    onChanged: search.onChange,
                    autofocus: false,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search"
                    ),
                  ),
                ))
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(2),
              child: StreamBuilder<QuerySnapshot>(
                  stream: category,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    userData = [];
                    snapshot.data!.docs.forEach((doc) {
                      userData.add(MItem.fromJson(data: doc.data() as Map,id: doc.id));
                    });
                    userDataSource = UserDataSource(userData);
                    return userData.isNotEmpty?
                    DataGrid(userDataSource: userDataSource,):
                    const Center(child: Text("Not Contain Any Item Yet"),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

