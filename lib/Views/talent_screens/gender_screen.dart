import 'package:beautyshot/Views/talent_screens/address_screen.dart';
import 'package:beautyshot/components/constants.dart';
import 'package:beautyshot/components/title_text.dart';
import 'package:beautyshot/components/top_row.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'date_of_birth_screen.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({Key? key}) : super(key: key);

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String gender = "";
  bool maleIconVisibility =false;
  bool femaleIconVisibility =false;
  bool genderConformingIconVisibility =false;
  bool nonBinaryIconVisibility =false;
  bool transFemaleIconVisibility =false;
  bool transMaleIconVisibility =false;
  bool unspecifiedIconVisibility =false;

  //Male
  onMaleClick()async{
    SharedPreferences prefs = await _prefs;
    setState(() {
      gender = 'male';
      prefs.setString('gender', gender);
      maleIconVisibility = true;
      femaleIconVisibility = false;
      genderConformingIconVisibility = false;
      nonBinaryIconVisibility = false;
      transFemaleIconVisibility = false;
      transMaleIconVisibility = false;
      unspecifiedIconVisibility = false;
    });
  }
  //Female
  onFemaleClick()async{
    SharedPreferences prefs = await _prefs;
    setState(() {
      gender = 'female';
      prefs.setString('gender', gender);
      maleIconVisibility = false;
      femaleIconVisibility = true;
      genderConformingIconVisibility = false;
      nonBinaryIconVisibility = false;
      transFemaleIconVisibility = false;
      transMaleIconVisibility = false;
      unspecifiedIconVisibility = false;
    });
  }
  //Gender Non Conforming
  onGenderConformingClick()async{
    SharedPreferences prefs = await _prefs;
    setState(() {
      gender = 'genderNonConforming';
      prefs.setString('gender', gender);
      maleIconVisibility = false;
      femaleIconVisibility = false;
      genderConformingIconVisibility = true;
      nonBinaryIconVisibility = false;
      transFemaleIconVisibility = false;
      transMaleIconVisibility = false;
      unspecifiedIconVisibility = false;

    });
  }
  // Non-Binary
  onNonBinaryClick()async{
    SharedPreferences prefs = await _prefs;
    setState(() {
      gender = 'nonBinary';
      prefs.setString('gender', gender);
      maleIconVisibility = false;
      femaleIconVisibility = false;
      genderConformingIconVisibility = false;
      nonBinaryIconVisibility = true;
      transFemaleIconVisibility = false;
      transMaleIconVisibility = false;
      unspecifiedIconVisibility = false;

    });
  }
  //TransFemale
  onTransFemaleClick()async{
    SharedPreferences prefs = await _prefs;
    setState(() {
      gender = 'transFemale';
      prefs.setString('gender', gender);
      maleIconVisibility = false;
      femaleIconVisibility = false;
      genderConformingIconVisibility = false;
      nonBinaryIconVisibility = false;
      transFemaleIconVisibility = true;
      transMaleIconVisibility = false;
      unspecifiedIconVisibility = false;

    });
  }
  //TransMale
  onTransMaleClick()async{
    SharedPreferences prefs = await _prefs;
    setState(() {
      gender = 'transMale';
      prefs.setString('gender', gender);
      maleIconVisibility = false;
      femaleIconVisibility = false;
      genderConformingIconVisibility = false;
      nonBinaryIconVisibility = false;
      transFemaleIconVisibility = false;
      transMaleIconVisibility = true;
      unspecifiedIconVisibility = false;

    });
  }
  //Unspecified
  onUnspecifiedClick()async{
    SharedPreferences prefs = await _prefs;
    setState(() {
      gender = 'unspecified';
      prefs.setString('gender', gender);
      maleIconVisibility = false;
      femaleIconVisibility = false;
      genderConformingIconVisibility = false;
      nonBinaryIconVisibility = false;
      transFemaleIconVisibility = false;
      transMaleIconVisibility = false;
      unspecifiedIconVisibility = true;

    });
  }


  onForwardPress(){
    Get.to(()=>const AddressScreen());
  }

  void persistLastRoute(String routeName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(Strings.lastRouteKey, routeName);
  }
  setInitialValues() async{
    SharedPreferences prefs = await _prefs;
    setState(() {
      if(prefs.getString('gender') != null) {
        gender =  prefs.getString('gender')!;
      }
      else{
        gender = "";
      }

      if(gender == 'male'){
        maleIconVisibility = true;
        femaleIconVisibility = false;
        genderConformingIconVisibility = false;
        nonBinaryIconVisibility = false;
        transFemaleIconVisibility = false;
        transMaleIconVisibility = false;
        unspecifiedIconVisibility = false;
      }
      else if(gender == 'female'){
        maleIconVisibility = false;
        femaleIconVisibility = true;
        genderConformingIconVisibility = false;
        nonBinaryIconVisibility = false;
        transFemaleIconVisibility = false;
        transMaleIconVisibility = false;
        unspecifiedIconVisibility = false;
      }
      else if(gender == 'genderNonConforming'){
        maleIconVisibility = false;
        femaleIconVisibility = false;
        genderConformingIconVisibility = true;
        nonBinaryIconVisibility = false;
        transFemaleIconVisibility = false;
        transMaleIconVisibility = false;
        unspecifiedIconVisibility = false;
      }
      else if(gender == 'nonBinary'){
        maleIconVisibility = false;
        femaleIconVisibility = false;
        genderConformingIconVisibility = false;
        nonBinaryIconVisibility = true;
        transFemaleIconVisibility = false;
        transMaleIconVisibility = false;
        unspecifiedIconVisibility = false;
      }
      else if(gender == 'transFemale'){
        maleIconVisibility = false;
        femaleIconVisibility = false;
        genderConformingIconVisibility = false;
        nonBinaryIconVisibility = false;
        transFemaleIconVisibility = true;
        transMaleIconVisibility = false;
        unspecifiedIconVisibility = false;
      }
      else if(gender == 'transMale'){
        maleIconVisibility = false;
        femaleIconVisibility = false;
        genderConformingIconVisibility = false;
        nonBinaryIconVisibility = false;
        transFemaleIconVisibility = false;
        transMaleIconVisibility = true;
        unspecifiedIconVisibility = false;
      }
      else if(gender == 'unspecified'){
        maleIconVisibility = false;
        femaleIconVisibility = false;
        genderConformingIconVisibility = false;
        nonBinaryIconVisibility = false;
        transFemaleIconVisibility = false;
        transMaleIconVisibility = true;
        unspecifiedIconVisibility = true;
      }

    });
  }
  @override
  void initState() {
    super.initState();
    persistLastRoute('/talentGender');
    setInitialValues();
  }
  Future<bool> _willPopCallback() async {
    Get.to(()=>const DateOfBirthScreen());
    return false;
    // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Row
              TopRow(4, 2),
                //Body

                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Title Text
                      TitleText(Strings.gender),
                      //SizedBox
                      const SizedBox(height: 30,),
                      //Male
                     GestureDetector(
                       onTap: onMaleClick,
                         // child: PlainWhiteButton(Strings.male),
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
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all( 20),
                                 child: Text(Strings.male,style: KFontStyle.kTextStyle16BlackRegular,),
                               ),
                               Visibility(
                                 visible: maleIconVisibility,
                                 child: const Padding(
                                   padding: EdgeInsets.only(left: 20,right: 20),
                                   child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                 ),
                               ),
                             ],
                           ),
                         )

                     ),
                      //FeMale
                      GestureDetector(
                          onTap: onFemaleClick,
                          // child: PlainWhiteButton(Strings.male),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all( 20),
                                  child: Text(Strings.female,style: KFontStyle.kTextStyle16BlackRegular,),
                                ),
                                Visibility(
                                  visible: femaleIconVisibility,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 20,right: 20),
                                    child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                  ),
                                ),
                              ],
                            ),
                          )

                      ),
                      //Gender Non Conforming
                      GestureDetector(
                          onTap: onGenderConformingClick,
                          // child: PlainWhiteButton(Strings.male),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all( 20),
                                  child: Text(Strings.genderNonConforming,style: KFontStyle.kTextStyle16BlackRegular,),
                                ),
                                Row(
                                  children: [
                                    Visibility(
                                      visible: genderConformingIconVisibility,
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 20,right: 20),
                                        child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )

                      ),
                      //Non-Binary
                      GestureDetector(
                          onTap: onNonBinaryClick,
                          // child: PlainWhiteButton(Strings.male),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all( 20),
                                  child: Text(Strings.nonBinary,style: KFontStyle.kTextStyle16BlackRegular,),
                                ),
                                Row(
                                  children: [
                                    Visibility(
                                      visible: nonBinaryIconVisibility,
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 20,right: 20),
                                        child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          )

                      ),
                      //TransFemale
                      GestureDetector(
                          onTap: onTransFemaleClick,
                          // child: PlainWhiteButton(Strings.male),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all( 20),
                                  child: Text(Strings.transFemale,style: KFontStyle.kTextStyle16BlackRegular,),
                                ),
                                Row(
                                  children: [
                                    Visibility(
                                      visible: transFemaleIconVisibility,
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 20,right: 20),
                                        child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          )

                      ),
                      //TransMale
                      GestureDetector(
                          onTap: onTransMaleClick,
                          // child: PlainWhiteButton(Strings.male),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all( 20),
                                  child: Text(Strings.transMale,style: KFontStyle.kTextStyle16BlackRegular,),
                                ),
                                Row(
                                  children: [
                                    Visibility(
                                      visible: transMaleIconVisibility,
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 20,right: 20),
                                        child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          )

                      ),
                      //Unspecified
                      GestureDetector(
                          onTap: onUnspecifiedClick,
                          // child: PlainWhiteButton(Strings.male),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all( 20),
                                  child: Text(Strings.unspecified,style: KFontStyle.kTextStyle16BlackRegular,),
                                ),
                                Row(
                                  children: [
                                    Visibility(
                                      visible: unspecifiedIconVisibility,
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 20,right: 20),
                                        child: Icon(Icons.check_circle,color: Colors.green,size: 32,),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(right: 20),
                                    //   child: Icon(Icons.navigate_next_rounded,size: 32,color: Color(KColors.kColorPrimary),),
                                    // ),

                                  ],
                                ),

                              ],
                            ),
                          )

                      ),
                      //SizedBox
                      const SizedBox(height: 30,),
                      //Back and Forward Button
                      // BackForwardButton(onForwardPress),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back Button
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>const DateOfBirthScreen());
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
                          GestureDetector(
                            onTap: onForwardPress,
                            child: const Icon(Icons.navigate_next_rounded,size: 52,),
                          ),
                        ],),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


