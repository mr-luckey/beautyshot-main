import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'constants.dart';

class Buttons {
  /// Back Forward Button
  static Widget backForwardButton(GestureTapCallback? onTap,){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back Button
        InkWell(
          onTap: (){
            Get.back();
          },
          child: Container(
            height: 56,
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
              color: Color(KColors.kColorWhite),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Color(KColors.kColorPrimary),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0,right: 40,top: 20,bottom: 20),
              child: Center(child: Text(Strings.back,style: KFontStyle.kTextStyle14Blue,)),
            ),
          ),
        ),
        //Forward Button
        InkWell(
          onTap: onTap,
          child: Icon(Icons.navigate_next_rounded,size: 52,),
        ),
      ],);
  }
  /// Blue Button
  static Widget blueButton(String title,GestureTapCallback? onTap, ){
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 62,
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          color: Color(KColors.kColorPrimary),
          borderRadius: BorderRadius.circular(50),
          // border: Border.all(
          //   color: Colors.grey,
          // ),
        ),
        child: Center(child: Text(title,style: KFontStyle.kTextStyle24White,)),
      ),
    );
  }
  /// Blue Rectangular Button
  static Widget blueRectangularButton(String title,GestureTapCallback? onTap, ){
    return InkWell(
      onTap: onTap,
      child:Container(
        height: 62,
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          color: Color(KColors.kColorPrimary),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(child: Text(title,style: KFontStyle.kTextStyle16White,)),
      ),
    );
  }
  /// Chat Button
  static Widget chatButton(GestureTapCallback? onTap, ){
    return InkWell(
      onTap: onTap,
      child:Column(
        children: [
          Container(
            height: 62,
            width: 62,
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            decoration: BoxDecoration(
              color: Color(KColors.kColorWhite),
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 5.0,
                ),
              ],

            ),
            child: Center(child:Image.asset("assets/images/chat_inactive.png",color: Color(KColors.kColorDarkGrey),height: 18,width: 18)),
          ),
        ],
      ),
    );
  }
  /// 1st and second Option Button
  static Widget optionButton(String title,GestureTapCallback? onTap, ){
    return InkWell(
      onTap: onTap,
      child:Column(
        children: [
          Container(
            height: 52,
            width: 52,
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            decoration: BoxDecoration(
              color: Color(KColors.kColorWhite),
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 5.0,
                ),
              ],

            ),
            child: Center(child: Text(title,style: KFontStyle.newYorkSemiBold10,)),
          ),
          const SizedBox(height: 10,),
          Text("Option",style: KFontStyle.kTextStyle14Grey,),
        ],
      ),
    );
  }
  /// Folder Button
  static Widget folderButton(GestureTapCallback? onTap, ){
    return InkWell(
      onTap: onTap,
      child:Column(
        children: [
          Container(
            height: 62,
            width: 62,
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            decoration: BoxDecoration(
              color: Color(KColors.kColorWhite),
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 5.0,
                ),
              ],

            ),
            child: Center(child:Image.asset("assets/images/project.png",color: Color(KColors.kColorDarkGrey),height: 18,width: 18)),
          ),
        ],
      ),
    );
  }
  /// Forward  Button
  static Widget forwardButton(GestureTapCallback? onTap, ){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //Forward Button
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: InkWell(
            onTap:onTap,
            child: Icon(Icons.navigate_next_rounded,size: 52,),
          ),
        ),
      ],);
  }
  /// Ignore  Button with text
  static Widget ignoreButton(GestureTapCallback? onTap, ){
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 52,
            width: 52,
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            decoration: BoxDecoration(
              color: Color(KColors.kColorWhite),
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 5.0,
                ),
              ],

            ),
            child: Center(child:Image.asset("assets/images/cross.png",height: 18,width: 18)),
          ),
          SizedBox(height: 10,),
          Text("Ignore",style: KFontStyle.kTextStyle14Grey,),
        ],
      ),
    );
  }
  /// White Button
  static Widget whiteButton(String title,GestureTapCallback? onTap, ){
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 62,
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          color: Color(KColors.kColorWhite),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Color(KColors.kColorPrimary),
          ),
        ),
        child: Center(child: Text(title,style: KFontStyle.kTextStyle16Blue,)),
      ),
    );
  }
  /// Plain White Button
  static Widget plainWhiteButton(String title,GestureTapCallback? onTap, ){
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all( 20),
              child: Text(title,style: KFontStyle.kTextStyle16BlackRegular,),
            ),
          ],
        ),
      ),
    );
  }
  ///  White Rectangular Button
  static Widget whiteRectangularButton(String title,GestureTapCallback? onTap, ){
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(title,style: KFontStyle.kTextStyle16BlackRegular,),
            ),
          ],
        ),
      ),
    );
  }




}
