import 'package:flutter/material.dart';

import 'constants.dart';

class TopRowWhite extends StatelessWidget {
 int flexWhite;

 TopRowWhite(this.flexWhite, {Key? key}) : super(key: key);

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
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 2.0), //(x,y)
                blurRadius: 5.0,
              ),
            ],
          ),
        ),),
    ],);
  }
}