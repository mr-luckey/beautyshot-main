import 'package:flutter/material.dart';

import 'constants.dart';

class TopRow extends StatelessWidget {
 int flexWhite;
 int flexBlue;

 TopRow(this.flexWhite, this.flexBlue, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: flexWhite,
        child: Container(
          height: 5,
          decoration: BoxDecoration(
            color: Color(KColors.kColorWhite),
            borderRadius: BorderRadius.circular(50),
          ),
        ),),
      Expanded(
        flex: flexBlue,
        child: Container(
          height: 5,
          decoration: BoxDecoration(
            color: Color(KColors.kColorPrimary),
            borderRadius: BorderRadius.circular(50),
          ),
        ),),
    ],);
  }
}