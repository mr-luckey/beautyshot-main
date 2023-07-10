import 'package:flutter/material.dart';

import 'constants.dart';

class PasswordRectTextField extends StatelessWidget {

  final bool obscure_text;
  final TextEditingController controller;
  final String title;


  PasswordRectTextField(this.obscure_text, this.controller, this.title);

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
        borderRadius: BorderRadius.circular(14),
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
              obscureText: obscure_text,
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