import 'package:epp_film/ui/utiles/constants.dart';
import 'package:flutter/material.dart';
class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);
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
      ),
    );
  }
}
