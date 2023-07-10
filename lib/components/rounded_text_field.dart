import 'package:flutter/material.dart';

import 'constants.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;


  RoundedTextField({required this.controller, required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 3.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.circular(50),
        // border: Border.all(
        //   color: Colors.grey,
        // ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5),
        child: TextField(

          style: KFontStyle.kTextStyle16BlackRegular,
          textCapitalization: TextCapitalization.words,
          controller: controller,
          autofocus: false,
          maxLines: 1,
          decoration: InputDecoration(

            border: InputBorder.none,
            hintText: title,
            hintStyle: KFontStyle.kTextStyle16BlackRegular,
          ),
        ),
      ),
    );
  }
}