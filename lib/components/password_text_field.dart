import 'package:flutter/material.dart';

import 'constants.dart';

class PasswordTextField extends StatelessWidget {

   final bool obscureText;
   final TextEditingController controller;
  final String title;


   const PasswordTextField({Key? key, required this.obscureText, required this.controller, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            width: 22,
            height: 22,
            child:  ImageIcon(
              AssetImage(KImages.password),
            ),
          ),
          Expanded(
            child: TextField(
              style: KFontStyle.kTextStyle16BlackRegular,
              controller: controller,
              autofocus: false,
              obscureText: obscureText,
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: title,
                hintStyle: KFontStyle.kTextStyle16BlackRegular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}