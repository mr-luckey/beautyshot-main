import 'package:flutter/material.dart';

import 'constants.dart';

class TitleText extends StatelessWidget {
  String title;


  TitleText(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Text(title,style: KFontStyle.kTextStyle26Black,),);
  }
}