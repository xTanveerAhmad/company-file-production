import 'package:epp_film/ui/page/homebody.dart';
import 'package:epp_film/ui/utiles/constants.dart';
import 'package:epp_film/ui/widgets/addbutton.dart';
import 'package:epp_film/ui/widgets/myappbar.dart';
import 'package:epp_film/ui/widgets/mydrawer.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppBar(),
      ),
      body: HomeBodyPage(),
      floatingActionButton: AddItemButton(),
      drawer: MyDrawer(),
    );
  }
}
