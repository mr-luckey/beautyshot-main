import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class EmailRectTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;


  const EmailRectTextField(this.controller, this.title, {Key? key}) : super(key: key);

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
            child: ImageIcon(
              AssetImage(KImages.email),
              size: 12,
            ),
          ),
          Expanded(
            child: TextField(
              style: KFontStyle.kTextStyle16BlackRegular,
              inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))],
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
        ],
      ),
    );
  }
}