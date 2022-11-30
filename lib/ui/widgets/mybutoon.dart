import 'package:flutter/material.dart';
class MyTextButton extends StatefulWidget {
  final String text;
  var onPressed;
  MyTextButton({Key? key,required this.text,required this.onPressed}) : super(key: key);

  @override
  State<MyTextButton> createState() => _MyTextButtonState();
}

class _MyTextButtonState extends State<MyTextButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(230, 28, 45, 1),
              borderRadius: BorderRadius.circular(3),
            ),
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Center(child:  Text(widget.text,
              style:const TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 17),)),
          ),
        ),
      ],
    );
  }
}
